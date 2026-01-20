//
//  WishChoiceViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import UIKit

final class WishChoiceViewController : UIViewController {
    typealias Model = WishChoiceModel
    
    // MARK: - Constants
    private enum Constants {
        // Strings
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let titleText: String = "Choose saved wish"
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: 20, weight: .bold)
        
        // UI Constraint properties
        static let titleTop: CGFloat = 10
        static let wrapWidth: CGFloat = 380
        static let wrapHeight: CGFloat = 700
        static let wrapCornerRadius: CGFloat = 10
        static let stackTop: CGFloat = 20
        static let stackLeft: CGFloat = 20
        static let titleLeftIndent: CGFloat = 10
        static let titleTopIndent: CGFloat = 10
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        // Numbers
        static let tableViewNumberOfSections = 1
        
        // Colors
        static let backgroundColor: UIColor = .white
        static let tableBackgroundColor: UIColor = .systemGray
        static let wrapColor: UIColor = .lightGray
    }
    
    // MARK: - Fields
    private let interactor: WishChoiceBusinessLogic
    
    private var wishArray: [Wish] = []
    
    private let titleLabel: UILabel = .init()
    
    var wishSelected: ((String) -> Void)?
    
    // Table views
    private let table: UITableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Lifecycle
    init(interactor: WishChoiceBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadWishes()
        
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        
        configureTitle()
        configureTableView()
    }
    
    
    // MARK: - Title configurtion
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.text = Constants.titleText
        titleLabel.font = Constants.titleFont
        
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
        titleLabel.pinCenterX(to: view)
    }
    
    // MARK: - Table configuration
    private func configureTableView() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.tableBackgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.isUserInteractionEnabled = true
        table.delegate = self
        
        table.pinTop(to: titleLabel.bottomAnchor, Constants.tableOffset)
        table.pinHorizontal(to: view, Constants.tableOffset)
        table.pinBottom(to: view.bottomAnchor, Constants.tableOffset)
        
        table.register(WishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
    
    // MARK: - Display logic
    func loadWishes(_ viewModel: Model.Fetch.ViewModel) {
        wishArray = viewModel.wishes
        table.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishChoiceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(
        _
        tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WishCell else { return cell }
        
        wishCell.configure(wish: wishArray[indexPath.row])
        
        return wishCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewNumberOfSections
    }
    
}

// MARK: - UITableViewDelegate
extension WishChoiceViewController : UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let wish = wishArray[indexPath.row]
        
        wishSelected?(wish.wishText ?? "")
        dismiss(animated: true)
    }
}
