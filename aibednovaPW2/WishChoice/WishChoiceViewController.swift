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
        
        // Colors
        static let backgroundColor: UIColor = .white
        static let wrapColor: UIColor = .lightGray
    }
    
    // MARK: - Fields
    private let interactor: WishChoiceBusinessLogic
    
    private let titleLabel: UILabel = .init()
    private let wrap: UIView = .init()
    
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
        
        configureWrap()
        configureTitle()
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
    
    // MARK: - Display logic
    func loadWishes(_ viewModel: Model) {
        
    }
}
