//
//  ViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 21.09.2025.
//

import UIKit

final class WishMakerViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Constants
    private enum constants {
        static let titleFontSize: CGFloat = 32
        static let textFontSize: CGFloat = 17
        
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: constants.titleFontSize, weight: .bold)
        static let textFont: UIFont = .monospacedSystemFont(ofSize: constants.textFontSize, weight: .regular)
        static let wishTextFont: UIFont = .monospacedSystemFont(ofSize: constants.textFontSize, weight: .bold)
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
        static let addWishButtonText = "Add wish"
        static let hexTextFieldText = "Enter color in hex"
        static let orText = "Or"
        static let red = "Red"
        static let green = "Green"
        static let blue = "Blue"
        
        static let titleTextColor: UIColor = .white
        static let descriptionTextColor: UIColor = .white
        static let wishTextColor: UIColor = .white
        static let buttonColor: UIColor = .darkGray
        static let addWishButtonColor: UIColor = .systemBlue
        static let textColor: UIColor = .white
        
        static let redInitValue: Double = 0.5
        static let blueInitValue: Double = 0.5
        static let greenInitValue: Double = 0.5
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
    }
    
    // MARK: Fields
    
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
    private let sliderRed = CustomSlider(title: constants.red, min: constants.minSliderValue, max: constants.maxSliderValue)
    private let sliderBlue = CustomSlider(title: constants.blue, min: constants.minSliderValue, max: constants.maxSliderValue)
    private let sliderGreen = CustomSlider(title: constants.green, min: constants.minSliderValue, max: constants.maxSliderValue)
    
    // Stacks
    private let stackView = UIStackView()
    
    // Buttons
    private let slidersButton = UIButton(type: .system)
    private let sendColorButton = UIButton()
    private let randomButton = UIButton(type: .roundedRect)
    private let addWishButton = UIButton(type: .roundedRect)
    
    // Utility variables
    var slidersHidden: Bool = false
    
    // RGB values
    private var redValue: Double = constants.redInitValue
    private var blueValue: Double = constants.blueInitValue
    private var greenValue: Double = constants.greenInitValue
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI configuration functions
    private func configureUI() {
        updateBackground()

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
    
    // MARK: TextViews
    private func configureTitle() {
        titleView.text = constants.titleText
        titleView.font = constants.titleFont
        titleView.textColor = constants.titleTextColor
        titleView.textAlignment = .center
        
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinLeft(to: view, constants.titleLeftIndent)
        titleView.pinTop(to: view, constants.titleTopIndent)
    }
    
    private func configureDescription() {
        descriptionView.text = constants.descriptionText
        descriptionView.font = constants.textFont
        descriptionView.textColor = constants.descriptionTextColor
        descriptionView.numberOfLines = constants.descriptionNumberOfLines
        
        view.addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: view.centerXAnchor)
        descriptionView.pinLeft(to: view, constants.descriptionLeftIndent)
        descriptionView.pinTop(to: titleView.bottomAnchor, constants.descriptionTopIndent)
    }
    
    private func configureWish1Text() {
        wish1View.text = constants.wish1Text
        wish1View.font = constants.wishTextFont
        wish1View.textColor = constants.textColor
        
        view.addSubview(wish1View)

        wish1View.pinCenterX(to: view.centerXAnchor)
        wish1View.pinLeft(to: view, constants.wish1TextLeftIndent)
        wish1View.pinTop(to: descriptionView.bottomAnchor, constants.wish1TextTopIndent)
    }
    
    private func configureOr1Text() {
        or1TitleView.textColor = constants.textColor
        or1TitleView.text = constants.orText
        
        view.addSubview(or1TitleView)
        
        or1TitleView.pinCenterX(to: view.centerXAnchor)
        or1TitleView.pinTop(to: stackView.bottomAnchor, constants.or1TextTopIndent)
    }
    
    private func configureOr2Text() {
        or2TitleView.textColor = constants.textColor
        or2TitleView.text = constants.orText
        
        view.addSubview(or2TitleView)
        
        or2TitleView.pinCenterX(to: view.centerXAnchor)
        or2TitleView.pinTop(to: hexColorTextField.bottomAnchor, constants.or2TextTopIndent)
    }
    
    // MARK: TextFields
    private func configureHexInput() {
        hexColorTextField.translatesAutoresizingMaskIntoConstraints = false
        
        hexColorTextField.placeholder = constants.hexTextFieldText
        hexColorTextField.borderStyle = .roundedRect
        hexColorTextField.backgroundColor = .white
        hexColorTextField.textColor = .black
        hexColorTextField.font = constants.textFieldFont
        
        view.addSubview(hexColorTextField)
        
        hexColorTextField.pinCenterX(to: view.centerXAnchor)
        hexColorTextField.pinLeft(to: view, 50)
        hexColorTextField.pinTop(to: or1TitleView.bottomAnchor, 10)
        
        hexColorTextField.delegate = self
    }
    
    // MARK: Buttons
    func configureSlidersButton() {
        slidersButton.setTitle(constants.hideSlidersButtonText, for: .normal)
        slidersButton.backgroundColor = constants.buttonColor
        slidersButton.layer.cornerRadius = constants.buttonCornerRadius
        
        view.addSubview(slidersButton)

        slidersButton.pinCenterX(to: view.centerXAnchor)
        slidersButton.pinLeft(to: view.leadingAnchor, constants.slidersButtonLeftIndent)
        slidersButton.pinTop(to: wish1View.bottomAnchor, constants.slidersButtonTopIndent)
        
        slidersButton.addTarget(self, action: #selector(slidersButtonPressed), for: .touchUpInside)
    }
    
    private func configureSendColorButton() {
        sendColorButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        
        view.addSubview(sendColorButton)
        
        sendColorButton.pinRight(to: hexColorTextField.trailingAnchor, constants.sendColorButtonRightIndent)
        sendColorButton.pinTop(to: hexColorTextField.topAnchor, constants.sendColorButtonTopIndent)
        sendColorButton.pinBottom(to: hexColorTextField.bottomAnchor, constants.sendColorButtonBottomIndent)
        
        sendColorButton.addTarget(self, action: #selector(sendColorButtonPressed), for: .touchUpInside)
    }
    
    private func configureRandomButton() {
        randomButton.layer.cornerRadius = constants.buttonCornerRadius
        randomButton.setTitle(constants.randomButtonText, for: .normal)
        randomButton.backgroundColor = constants.buttonColor
        
        view.addSubview(randomButton)
        
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinLeft(to: view.leadingAnchor, constants.randomButtonLeftIndent)
        randomButton.pinTop(to: or2TitleView.bottomAnchor, constants.randomButtonTopIndent)
        
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    private func configureAddWishButton() {
        addWishButton.layer.cornerRadius = constants.buttonCornerRadius
        addWishButton.setTitle(constants.addWishButtonText, for: .normal)
        addWishButton.backgroundColor = constants.addWishButtonColor
        addWishButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(addWishButton)
        
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinBottom(to: view.bottomAnchor, constants.addWishButtonBottomIndent)
        addWishButton.pinLeft(to: view.leadingAnchor, constants.addWishButtonLeftIndent)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Sliders
    private func configureSliders() {
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.layer.cornerRadius = constants.stackCornerRadius
        stackView.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stackView.addArrangedSubview(slider)
        }

        stackView.pinCenterX(to: view.centerXAnchor)
        stackView.pinLeft(to: view.leadingAnchor, constants.stackLeftIndent)
        stackView.pinTop(to: slidersButton.bottomAnchor, constants.stackTopIndent)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.redValue = value
            self?.updateBackground()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.blueValue = value
            self?.updateBackground()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.greenValue = value
            self?.updateBackground()
        }
    }
    
    // MARK: Auxilary functions
    
    // updateBackground function to change bg color for wish 1
    private func updateBackground(hexcolor: String = "") {
        if (hexcolor == "") {
            view.backgroundColor = .init(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1)
        } else {
            view.backgroundColor = UIColor(hex: hexcolor)
        }
    }
    
    private func configureWish2() {
        // TODO: finish wish 2 (in later PWs perhaps?) )
    }
    
    private func configureWish3() {
        // TODO: finish wish 3 (in later PWs perhaps?) )
    }
    
    // MARK: Button functions
    @objc func slidersButtonPressed() {
        if (slidersHidden) {
            stackView.isHidden = false
            slidersHidden = false
            
            slidersButton.setTitle(constants.hideSlidersButtonText, for: .normal)
        } else {
            stackView.isHidden = true
            slidersHidden = true
            
            slidersButton.setTitle(constants.showSlidersButtonText, for: .normal)
        }
    }
    
    @objc func sendColorButtonPressed() {
        updateBackground(hexcolor: hexColorTextField.text ?? "")
    }
    
    @objc func randomButtonPressed() {
        redValue = Double.random(in: constants.minSliderValue...constants.maxSliderValue)
        blueValue = Double.random(in: constants.minSliderValue...constants.maxSliderValue)
        greenValue = Double.random(in: constants.minSliderValue...constants.maxSliderValue)
        
        updateBackground()
    }
    
    @objc func addWishButtonPressed() {
        
    }
}

