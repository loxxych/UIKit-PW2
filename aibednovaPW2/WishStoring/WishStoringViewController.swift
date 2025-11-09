//
//  WishStoringViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    typealias Model = WishStoringModel
    
    // MARK: -Constants
    enum Constants {
        static let tableBackgroundColor: UIColor = .systemGray
        
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        static let tableViewNumberOfSections: Int = 2
    }
    
    // MARK: -Fields
    private let interactor: WishStoringInteractorProtocol
    
    private let table: UITableView = UITableView(frame: .zero, style: .plain)
    private var wishArray: [Wish] = []
    
    // MARK: -Lifecycle methods
    init(interactor: WishStoringInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.loadStart(WishStoringModel.Start.Request())
    }
    
    // MARK: UI Configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.tableBackgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
        
        table.isUserInteractionEnabled = true
        
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
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.addWish = { [weak self] wishText in
                self?.interactor.addWish(Model.AddWish.Request(wishText: wishText))
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
                           deleteWish: { [weak self] in
            self?.interactor.deleteWish(Model.DeleteWish.Request(wish: currWish))
            self?.interactor.loadWishes(Model.Fetch.Request())
        },
                           editWish: { [weak self] in
            self?.interactor.editWish(WishStoringModel.EditWish.Request(indexPath: indexPath))
        },
                           sendWish: { [weak self] newWishText in
            self?.interactor.sendWish(Model.SendWish.Request(indexPath: indexPath, wish: currWish, newWishText: newWishText))
            self?.interactor.loadWishes(Model.Fetch.Request())
        }
        )
        
        return wishCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewNumberOfSections
    }
}
