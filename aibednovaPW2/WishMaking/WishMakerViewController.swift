//
//  ViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 21.09.2025.
//

import UIKit

final class WishMakerViewController: UIViewController, UITextFieldDelegate {
    typealias Model = WishMakerModel
    
    // MARK: Constants
    private enum Constants {
        // Numbers
        static let animationDuration: CGFloat = 1
        
        // UI Constraint properties
        static let buttonCornerRadius: CGFloat = 10
        static let titleLeftIndent: CGFloat = 20
        static let titleTopIndent: CGFloat = 50
        static let addWishButtonBottomIndent: CGFloat = 20
        static let addWishButtonLeftIndent: CGFloat = 150
        static let elementSpacing: CGFloat = 10
        static let wish1ViewHorizontalIndent: CGFloat = 20
        static let spacing: CGFloat = 10
        static let actionStackViewBottomIndent: CGFloat = 20
        static let actionStackViewLeftIndent: CGFloat = 40
        static let scheduleButtonLeftIndent: CGFloat = 50
        static let stackWidth: CGFloat = 200
        
        // Strings
        static let titleText: String = "WishMaker"
        static let descriptionText: String = "Let's just get this over with. Three wishes. One chance to make a difference. Choose wisely."
        static let addWishButtonText: String = "My wishes"
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let scheduleButtonText: String = "Schedule wish granting"
        
        // Colors
        static let addWishButtonColor: UIColor = .systemBlue
        static let scheduleButtonColor: UIColor = .systemBlue
        static let textColor: UIColor = .white
        static let alpha: CGFloat = 1
    }
    
    // MARK: Fields
    private let interactor: WishMakerBusinessLogic
    
    // Custom views
    private let titleView = WishTitleView(title: Constants.titleText, description: Constants.descriptionText)
    private lazy var wish1View: Wish1View = {
        let view = Wish1View()
        return view
    }()
    
    // Buttons
    private let addWishButton: UIButton = UIButton(type: .roundedRect)
    private let scheduleButton: UIButton = UIButton(type: .roundedRect)
    
    // Stacks
    private let actionStackView: UIStackView = UIStackView()
    
    //MARK: - Lifecycle methods
    init(interactor: WishMakerBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadStart(.init())
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureTitle()
        configureWish1()
        configureActionStackView()
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        view.addSubview(titleView)
        
        titleView.pinTop(to: view.topAnchor, Constants.titleTopIndent)
        titleView.pinHorizontal(to: view, Constants.titleLeftIndent)
    }
    
    // MARK: - Wish 1 configuration
    private func configureWish1() {
        wish1View = Wish1View()
        
        wish1View.onColorChanged = { [weak self] red, green, blue in
            self?.interactor.updateColor(.init(red: red, green: green, blue: blue))
        }
        
        wish1View.onRandomButtonPressed = { [weak self] in
            self?.interactor.generateRandomColor(.init())
        }
        
        wish1View.onSendHex = { [weak self] hex in
            self?.interactor.updateColor(.init(hex: hex))
        }
        
        wish1View.onSlidersToggle = { [weak self] in
            self?.interactor.toggleSliders(.init())
        }
        
        view.addSubview(wish1View)
        
        wish1View.pinTop(to: titleView.bottomAnchor, Constants.elementSpacing)
        wish1View.pinHorizontal(to: view, Constants.wish1ViewHorizontalIndent)
    }
    
    private func configureWish2() {
        // TODO: finish wish 2 (in later PWs perhaps?) )
    }
    
    private func configureWish3() {
        // TODO: finish wish 3 (in later PWs perhaps?) )
    }
    
    // MARK: - Add wish button configuration
    private func configureAddWishButton() {
        addWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.backgroundColor = Constants.addWishButtonColor
        addWishButton.setTitleColor(Constants.textColor, for: .normal)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Schedule wish granting button configuration
    private func configureScheduleButton() {
        scheduleButton.layer.cornerRadius = Constants.buttonCornerRadius
        scheduleButton.setTitle(Constants.scheduleButtonText, for: .normal)
        scheduleButton.backgroundColor = Constants.scheduleButtonColor
        scheduleButton.setTitleColor(Constants.textColor, for: .normal)
        
        scheduleButton.addTarget(self, action: #selector(scheduleButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Action stack view configuration
    private func configureActionStackView() {
        actionStackView.axis = .vertical
        actionStackView.spacing = Constants.spacing
        
        view.addSubview(actionStackView)
        
        for button in [addWishButton, scheduleButton] {
            actionStackView.addArrangedSubview(button)
        }
        
        configureAddWishButton()
        configureScheduleButton()
        
        actionStackView.pinBottom(to: view.bottomAnchor, Constants.actionStackViewBottomIndent)
        actionStackView.pinCenterX(to: view.centerXAnchor)
        actionStackView.setWidth(Constants.stackWidth)
    }
    
    // MARK: - Button press functions
    @objc func addWishButtonPressed() {
        interactor.showAddWishViewController(Model.ShowAddWishViewController.Request())
    }
    
    @objc func scheduleButtonPressed() {
        interactor.showCalendarViewController(Model.ShowCalendarViewController.Request())
    }
    
    // MARK: - Display logic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        // Change background color to init rgb values
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        updateActionButtonColors(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Sets background to given color
    func displayColorUpdate(_ viewModel: Model.ColorUpdate.ViewModel) {
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        updateActionButtonColors(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Hides or shows sliders
    func displayToggleSliders(_ viewModel: Model.ToggleSliders.ViewModel) {
        wish1View.toggleSliders(isHidden: viewModel.isHidden)
    }
    
    // Sets background to given random color
    func displayRandomColor(_ viewModel: Model.RandomColor.ViewModel) {
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        updateActionButtonColors(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Changes backgound color
    private func changeBackground(red: CGFloat, green: CGFloat, blue: CGFloat) {
        wish1View.randomButton.isEnabled = false
        UIView.animate(withDuration: 1.0,
                       animations: {
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.alpha)
        },
                       completion: { [weak self] _ in
            self?.wish1View.randomButton.isEnabled = true
        }
        )
    }
    
    // Changes action button colors depending on the bg color
    private func updateActionButtonColors(red: CGFloat, green: CGFloat, blue: CGFloat) {
        let inversedRed = 1 - red
        let inversedGreen = 1 - green
        let inversedBlue = 1 - blue
        
        UIView.animate(withDuration: 1.0,
                       animations: {
            self.addWishButton.backgroundColor = UIColor(red: inversedRed, green: inversedGreen, blue: inversedBlue, alpha: Constants.alpha)
            self.scheduleButton.backgroundColor = UIColor(red: inversedRed, green: inversedGreen, blue: inversedBlue, alpha: Constants.alpha)
        }
        )
    }
}

