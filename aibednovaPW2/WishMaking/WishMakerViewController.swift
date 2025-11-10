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
        static let titleFontSize: CGFloat = 32
        static let textFontSize: CGFloat = 17
        static let animationDuration: CGFloat = 1
        
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: Constants.titleFontSize, weight: .bold)
        static let textFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .regular)
        static let wishTextFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .bold)
        static let textFieldFont: UIFont = .systemFont(ofSize: 17, weight: .medium)
        
        static let buttonCornerRadius: CGFloat = 10
        static let stackCornerRadius: CGFloat = 20
        
        static let titleLeftIndent: CGFloat = 20
        static let titleTopIndent: CGFloat = 50
        static let descriptionLeftIndent:CGFloat = 20
        static let descriptionTopIndent:CGFloat = 20
        static let sendColorButtonRightIndent: CGFloat = 10
        static let sendColorButtonTopIndent: CGFloat = 0
        static let sendColorButtonBottomIndent: CGFloat = 0
        static let randomButtonLeftIndent: CGFloat = 140
        static let randomButtonTopIndent: CGFloat = 10
        static let addWishButtonBottomIndent: CGFloat = 20
        static let addWishButtonLeftIndent: CGFloat = 150
        static let hexTextFieldLeftIndent: CGFloat = 20
        static let hexTextFieldTopIndent: CGFloat = 20
        static let or1TextTopIndent: CGFloat = 10
        static let wish1TextLeftIndent: CGFloat = 60
        static let wish1TextTopIndent: CGFloat = 20
        static let slidersButtonLeftIndent: CGFloat = 150
        static let slidersButtonTopIndent: CGFloat = 20
        static let or2TextTopIndent: CGFloat = 10
        static let stackLeftIndent: CGFloat = 20
        static let stackTopIndent: CGFloat = 20
        
        static let descriptionNumberOfLines = 3
        
        static let titleText = "WishMaker"
        static let descriptionText = "Let's just get this over with. Three wishes. One chance to make a difference. Choose wisely."
        static let wish1Text = "· Change bg color:"
        static let wish2Text = "WISH2"
        static let wish3Text = "WISH3"
        static let hideSlidersButtonText = "Hide sliders"
        static let showSlidersButtonText = "Show sliders"
        static let randomButtonText = "Random color"
        static let addWishButtonText = "My wishes"
        static let hexTextFieldText = "Enter color in hex"
        static let orText = "Or"
        static let red = "Red"
        static let green = "Green"
        static let blue = "Blue"
        
        static let sendButtonImage: UIImage? = UIImage(systemName: "arrow.right.circle.fill")
        
        static let titleTextColor: UIColor = .white
        static let descriptionTextColor: UIColor = .white
        static let wishTextColor: UIColor = .white
        static let buttonColor: UIColor = .darkGray
        static let addWishButtonColor: UIColor = .systemBlue
        static let textColor: UIColor = .white
        
        static let alpha: CGFloat = 1
        static let redInitValue: Double = 0.5
        static let blueInitValue: Double = 0.5
        static let greenInitValue: Double = 0.5
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
    }
    
    // MARK: Fields
    private let interactor: WishMakerBusinessLogic
    
    // Labels
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    private let wish1View = UILabel()
    private let wish2View = UILabel()
    private let wish3View = UILabel()
    private let or1TitleView = UILabel()
    private let or2TitleView = UILabel()
    
    // Text fields
    private let hexColorTextField = UITextField()
    
    // Sliders
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    
    // Stacks
    private let stackView = UIStackView()
    
    // Buttons
    private let slidersButton = UIButton(type: .system)
    private let sendColorButton = UIButton()
    private let randomButton = UIButton(type: .roundedRect)
    private let addWishButton = UIButton(type: .roundedRect)
    
    // Utility variables
    var slidersHidden: Bool = false
    
    //MARK: - Lifecycle methods
    init(interactor: WishMakerBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureTitle()
        configureDescription()
        
        configureWish1()
        
        configureAddWishButton()
    }
    
    private func configureWish1() {
        configureWish1Text()
        configureSlidersButton()
        configureSliders()
        configureOr1Text()
        configureHexInput()
        configureSendColorButton()
        configureOr2Text()
        configureRandomButton()
    }
    
    private func configureWish2() {
        // TODO: finish wish 2 (in later PWs perhaps?) )
    }
    
    private func configureWish3() {
        // TODO: finish wish 3 (in later PWs perhaps?) )
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        titleView.text = Constants.titleText
        titleView.font = Constants.titleFont
        titleView.textColor = Constants.titleTextColor
        titleView.textAlignment = .center
        
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinLeft(to: view, Constants.titleLeftIndent)
        titleView.pinTop(to: view, Constants.titleTopIndent)
    }
    
    // MARK: - Description configuration
    private func configureDescription() {
        descriptionView.text = Constants.descriptionText
        descriptionView.font = Constants.textFont
        descriptionView.textColor = Constants.descriptionTextColor
        descriptionView.numberOfLines = Constants.descriptionNumberOfLines
        
        view.addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: view.centerXAnchor)
        descriptionView.pinLeft(to: view, Constants.descriptionLeftIndent)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTopIndent)
    }
    
    // MARK: - Wish 1 configuration
    private func configureWish1Text() {
        wish1View.text = Constants.wish1Text
        wish1View.font = Constants.wishTextFont
        wish1View.textColor = Constants.textColor
        
        view.addSubview(wish1View)
        
        wish1View.pinCenterX(to: view.centerXAnchor)
        wish1View.pinLeft(to: view, Constants.wish1TextLeftIndent)
        wish1View.pinTop(to: descriptionView.bottomAnchor, Constants.wish1TextTopIndent)
    }
    
    private func configureOr1Text() {
        or1TitleView.textColor = Constants.textColor
        or1TitleView.text = Constants.orText
        
        view.addSubview(or1TitleView)
        
        or1TitleView.pinCenterX(to: view.centerXAnchor)
        or1TitleView.pinTop(to: stackView.bottomAnchor, Constants.or1TextTopIndent)
    }
    
    private func configureOr2Text() {
        or2TitleView.textColor = Constants.textColor
        or2TitleView.text = Constants.orText
        
        view.addSubview(or2TitleView)
        
        or2TitleView.pinCenterX(to: view.centerXAnchor)
        or2TitleView.pinTop(to: hexColorTextField.bottomAnchor, Constants.or2TextTopIndent)
    }
    
    // MARK: - Hex input configuration
    private func configureHexInput() {
        hexColorTextField.translatesAutoresizingMaskIntoConstraints = false
        
        hexColorTextField.placeholder = Constants.hexTextFieldText
        hexColorTextField.borderStyle = .roundedRect
        hexColorTextField.backgroundColor = .white
        hexColorTextField.textColor = .black
        hexColorTextField.font = Constants.textFieldFont
        
        view.addSubview(hexColorTextField)
        
        hexColorTextField.pinCenterX(to: view.centerXAnchor)
        hexColorTextField.pinLeft(to: view, 50)
        hexColorTextField.pinTop(to: or1TitleView.bottomAnchor, 10)
        
        hexColorTextField.delegate = self
    }
    
    // MARK: - Sliders button configuration
    func configureSlidersButton() {
        slidersButton.setTitle(Constants.hideSlidersButtonText, for: .normal)
        slidersButton.backgroundColor = Constants.buttonColor
        slidersButton.layer.cornerRadius = Constants.buttonCornerRadius
        
        view.addSubview(slidersButton)
        
        slidersButton.pinCenterX(to: view.centerXAnchor)
        slidersButton.pinLeft(to: view.leadingAnchor, Constants.slidersButtonLeftIndent)
        slidersButton.pinTop(to: wish1View.bottomAnchor, Constants.slidersButtonTopIndent)
        
        slidersButton.addTarget(self, action: #selector(slidersButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Send color button configuration
    private func configureSendColorButton() {
        sendColorButton.setImage(Constants.sendButtonImage, for: .normal)
        
        view.addSubview(sendColorButton)
        
        sendColorButton.pinRight(to: hexColorTextField.trailingAnchor, Constants.sendColorButtonRightIndent)
        sendColorButton.pinTop(to: hexColorTextField.topAnchor, Constants.sendColorButtonTopIndent)
        sendColorButton.pinBottom(to: hexColorTextField.bottomAnchor, Constants.sendColorButtonBottomIndent)
        
        sendColorButton.addTarget(self, action: #selector(sendColorButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Random button configuration
    private func configureRandomButton() {
        randomButton.layer.cornerRadius = Constants.buttonCornerRadius
        randomButton.setTitle(Constants.randomButtonText, for: .normal)
        randomButton.backgroundColor = Constants.buttonColor
        
        view.addSubview(randomButton)
        
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinLeft(to: view.leadingAnchor, Constants.randomButtonLeftIndent)
        randomButton.pinTop(to: or2TitleView.bottomAnchor, Constants.randomButtonTopIndent)
        
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Add wish button configuration
    private func configureAddWishButton() {
        addWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.backgroundColor = Constants.addWishButtonColor
        addWishButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(addWishButton)
        
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinBottom(to: view.bottomAnchor, Constants.addWishButtonBottomIndent)
        addWishButton.pinLeft(to: view.leadingAnchor, Constants.addWishButtonLeftIndent)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Sliders configuration
    private func configureSliders() {
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.layer.cornerRadius = Constants.stackCornerRadius
        stackView.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stackView.addArrangedSubview(slider)
        }
        
        stackView.pinCenterX(to: view.centerXAnchor)
        stackView.pinLeft(to: view.leadingAnchor, Constants.stackLeftIndent)
        stackView.pinTop(to: slidersButton.bottomAnchor, Constants.stackTopIndent)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.interactor.updateColor(WishMakerModel.ColorUpdate.Request(red: value))
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.interactor.updateColor(WishMakerModel.ColorUpdate.Request(blue: value))
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.interactor.updateColor(WishMakerModel.ColorUpdate.Request(green: value))
        }
    }
    
    // MARK: Button press functions
    @objc func slidersButtonPressed() {
        interactor.toggleSliders(Model.ToggleSliders.Request())
    }
    
    @objc func sendColorButtonPressed() {
        let hex = hexColorTextField.text ?? ""
        interactor.updateColor(Model.ColorUpdate.Request(hex: hex))
    }
    
    @objc func randomButtonPressed() {
        interactor.generateRandomColor(Model.RandomColor.Request())
    }
    
    @objc func addWishButtonPressed() {
        interactor.showAddWishViewController(Model.ShowAddWishViewController.Request())
    }
    
    // MARK: - Display logic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        // Change background color to init rgb values
        changeBackgroundAndSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Sets background to given color
    func displayColorUpdate(_ viewModel: Model.ColorUpdate.ViewModel) {
        changeBackgroundAndSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Hides or shows sliders
    func displayToggleSliders(_ viewModel: Model.ToggleSliders.ViewModel) {
        stackView.isHidden = viewModel.isHidden
        slidersButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    // Sets background to given random color
    func displayRandomColor(_ viewModel: Model.RandomColor.ViewModel) {
        displayColorUpdate(Model.ColorUpdate.ViewModel(red: viewModel.red, green: viewModel.green, blue: viewModel.blue))
    }
    
    // MARK: - Utility functions
    private func changeBackgroundAndSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
        randomButton.isEnabled = false
        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: {
                self.view.backgroundColor = UIColor(
                    red: red,
                    green: green,
                    blue: blue,
                    alpha: Constants.alpha
                )
            },
            completion: { [weak self] _ in
                self?.randomButton.isEnabled = true
            }
        )
        
        sliderRed.sliderValue = red
        sliderGreen.sliderValue = green
        sliderBlue.sliderValue = blue
    }
}

