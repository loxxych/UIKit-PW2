//
//  WishEventCreationViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import UIKit

final class WishEventCreationViewController : UIViewController {
    // MARK: - Constants
    private enum Constants {
        // Text
        static let titleText: String = "Add a new wish event"
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: 20, weight: .bold)
        
        // UI Constraint properties
        static let titleTop: CGFloat = 10
        static let wrapWidth: CGFloat = 380
        static let wrapHeight: CGFloat = 700
        static let wrapCornerRadius: CGFloat = 10
        static let stackTop: CGFloat = 20
        static let stackLeft: CGFloat = 20
        
        // Colors
        static let backgroundColor: UIColor = .white
        static let wrapColor: UIColor = .lightGray
    }
    
    // MARK: - Fields
    private var interactor: WishEventCreationBusinessLogic
    
    private let titleLabel: UILabel = .init()
    private let wishEventTextFieldStack: WishEventTextFieldStack = .init()
    private let wrap: UIView = .init()
    
    // MARK: - Lifecycle
    init(interactor: WishEventCreationBusinessLogic) {
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
        
        configureWrap()
        configureTitle()
        configureStackView()
    }
    
    // MARK: - Stack view configuration
    private func configureStackView() {
        view.addSubview(wishEventTextFieldStack)
        
        wishEventTextFieldStack.saveEvent = { model in
            self.interactor.addWish(WishEventCreationModel.AddWishEvent.Request(wishEvent: model))
        }
        
        wishEventTextFieldStack.pinTop(to: wrap.topAnchor, Constants.stackTop)
        wishEventTextFieldStack.pinHorizontal(to: wrap, Constants.stackLeft)
    }
    
    // MARK: - Wrap configuration
    private func configureWrap() {
        view.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrap.setWidth(Constants.wrapWidth)
        wrap.setHeight(Constants.wrapHeight)
        wrap.pinCenter(to: view)
    }
    
    // MARK: - Title configurtion
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.text = Constants.titleText
        titleLabel.font = Constants.titleFont
        
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
        titleLabel.pinCenterX(to: view)
    }
}
