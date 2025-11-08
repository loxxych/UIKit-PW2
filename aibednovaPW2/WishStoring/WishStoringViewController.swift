//
//  WishStoringViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: Fields
    private let table: UITableView = UITableView(frame: .zero, style: .plain)
    private var wishArray: [String] = ["I wish to add cells to the table", "I wish to kis Jammy"]
    private let defaults = UserDefaults.standard
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Constants
    enum Constants {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        static let tableViewNumberOfSections: Int = 2
    }
    
    
    // MARK: UI Configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(table)
        
        table.backgroundColor = .systemTeal
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
        
        table.isUserInteractionEnabled = true
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func addWish(_ wish: String) {
        wishArray.append(wish)
        
        let newIndexPath = IndexPath(row: wishArray.count - 1, section: 1)
        table.insertRows(at: [newIndexPath], with: .automatic)
        
        DispatchQueue.main.async {
            self.table.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        
        // defaults.set(stringArray, forKey: Constants.wishesKey)
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
                self?.addWish(wishText)
            }
            
            return addWishCell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wishCell.configure(with: wishArray[indexPath.row])
        return wishCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewNumberOfSections
    }
}
