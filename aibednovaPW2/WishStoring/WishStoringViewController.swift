//
//  WishStoringViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    typealias Model = WishStoringModel
    
    // MARK: - Constants
    enum Constants {
        // Numbers
        static let tableViewNumberOfSections: Int = 2
        static let addWishSection: Int = 0
        
        // Strings
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let titleText: String = "My wishes"
        
        // Fonts
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: 24, weight: .bold)
        
        // Colors
        static let tableBackgroundColor: UIColor = .systemGray
        
        // UI Constraint properties
        static let titleLeftIndent: CGFloat = 10
        static let titleTopIndent: CGFloat = 10
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
    }
    
    // MARK: - Fields
    private let interactor: WishStoringBusinessLogic
    
    private let table: UITableView = UITableView(frame: .zero, style: .plain)
    let titleView: UILabel = UILabel()
    private var wishArray: [Wish] = []
    
    // MARK: - Lifecycle methods
    init(interactor: WishStoringBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.loadStart(WishStoringModel.Start.Request())
    }
    
    // MARK: UI Configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureTitle()
        configureTableView()
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        titleView.text = Constants.titleText
        titleView.font = Constants.titleFont
        
        view.addSubview(titleView)
        
        titleView.pinTop(to: view.topAnchor, Constants.titleTopIndent)
        titleView.pinCenterX(to: view)
    }
    
    // MARK: - Table configuration
    private func configureTableView() {
        view.addSubview(table)

        table.backgroundColor = Constants.tableBackgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.isUserInteractionEnabled = true
        
        table.pinTop(to: titleView.bottomAnchor, Constants.tableOffset)
        table.pinHorizontal(to: view, Constants.tableOffset)
        table.pinBottom(to: view.bottomAnchor, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    // MARK: - Display logic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        updateData(wishes: viewModel.wishes)
    }
    
    func displayNewWish(_ viewModel: Model.Fetch.ViewModel) {
        updateData(wishes: viewModel.wishes)
    }
    
    func displayCellEditMode(_ viewModel: Model.EditWish.ViewModel) {
        if let cell = table.cellForRow(at: viewModel.indexPath) as? WrittenWishCell {
                    cell.startEditing()
                }
    }
    
    func displayEndCellEditMode(_ viewModel: Model.SendWish.ViewModel) {
        if let cell = table.cellForRow(at: viewModel.indexPath) as? WrittenWishCell {
                    cell.finishEditing()
                }
    }
    
    // MARK: - Utility functions
    func updateData(wishes: [Wish]) {
        wishArray = wishes
        table.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : wishArray.count
    }
    
    func tableView(
        _
        tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if (indexPath.section == Constants.addWishSection) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            // Set the add wish closure for addWishCell
            addWishCell.addWish = { [weak self] wishText in
                // Add the wish to wishes
                self?.interactor.addWish(Model.AddWish.Request(wishText: wishText))
                // Reload table with updated wishes
                self?.interactor.loadWishes(Model.Fetch.Request())
            }
            
            return addWishCell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        let currWish = wishArray[indexPath.row]
        
        wishCell.configure(wish: wishArray[indexPath.row],
                           deleteWish: { [weak self] in // Set the delete wish closure
            // Delete the wish from wishes
            self?.interactor.deleteWish(Model.DeleteWish.Request(wish: currWish))
            // Reload table with updated wishes
            self?.interactor.loadWishes(Model.Fetch.Request())
        },
                           editWish: { [weak self] in // Set the edit wish closure
            // Set cell to editing / non editing mode
            self?.interactor.editWish(WishStoringModel.EditWish.Request(indexPath: indexPath))
        },
                           sendWish: { [weak self] newWishText in // Set the send wish closure
            // Rewrite current wish in wishes
            self?.interactor.sendWish(Model.SendWish.Request(indexPath: indexPath, wish: currWish, newWishText: newWishText))
            // Reload table with updated wishes
            self?.interactor.loadWishes(Model.Fetch.Request())
        }
        )
        
        return wishCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewNumberOfSections
    }
}
