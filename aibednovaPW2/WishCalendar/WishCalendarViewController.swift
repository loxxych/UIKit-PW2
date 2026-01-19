//
//  WishCalendarViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    typealias Model = WishCalendarModel
    
    // MARK: - Constants
    private enum Constants {
        // Text
        static let titleText: String = "Wish calendar"
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: 24, weight: .bold)
        
        // UI constraints and properties
        static let contentInset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
        static let collectionTop: CGFloat = 40
        static let addButtonTop: CGFloat = 10
        static let addButtonSize: CGFloat = 40
        static let buttonCornerRadius: CGFloat = addButtonSize / 2
        
        // Colors
        static let backgroundColor: UIColor = .white
        static let addButtonColor: UIColor = .systemBlue
        static let addButtonTintColor: UIColor = .white
        
        // Images
        static let addButtonImage: UIImage? = UIImage(systemName: "plus")
    }
    
    // MARK: - Fields
    private let interactor: WishCalendarBusinessLogic
    
    private let titleLabel: UILabel = .init()
    private let addButton: UIButton = .init(type: .roundedRect)
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    init(interactor: WishCalendarBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        configureTitle()
        configureAddButton()
        configureCollection()
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.font = Constants.titleFont
        titleLabel.text = Constants.titleText
        
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.pinCenterX(to: view)
    }
    // MARK: - Collection configuration
    private func configureCollection() {
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
        
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: addButton.topAnchor, Constants.collectionTop)
    }
    
    // MARK: - Add button configuration
    private func configureAddButton() {
        view.addSubview(addButton)
        
        addButton.setImage(Constants.addButtonImage, for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.tintColor = Constants.addButtonTintColor
        addButton.backgroundColor = Constants.addButtonColor
        addButton.layer.cornerRadius = Constants.buttonCornerRadius
        addButton.isUserInteractionEnabled = true

        addButton.pinCenterX(to: view)
        addButton.pinTop(to: titleLabel.bottomAnchor, Constants.addButtonTop)
        addButton.setWidth(Constants.addButtonSize)
        addButton.setHeight(Constants.addButtonSize)
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Button press functions
    @objc private func addButtonPressed() {
        interactor.showWishEventCreationViewController(Model.ShowWishEventCreationViewController.Request())
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
