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
        static let descriptionFontSize: CGFloat = 17
        static let wishFontSize: CGFloat = 20
        
        static let slidersButtonFontSize: CGFloat = 17
        static let buttonCornerRadius: CGFloat = 10
        static let sendColorButtonLeftConst: CGFloat = 70
        static let sendColorButtonTopConst: CGFloat = 7
        
        static let descriptionNumberOfLines = 3
        
        static let titleText = "WishMaker"
        static let descriptionText = "Let's just get this over with. Three wishes. One chance to make a difference. Choose wisely."
        static let wish1Text = "· Change bg color:"
        static let wish2Text = "WISH2"
        static let wish3Text = "WISH3"
        static let hideSlidersButtonText = "Hide sliders"
        static let showSlidersButtonText = "Show sliders"
        static let randomButtonText = "Random color"
        static let red = "Red"
        static let green = "Green"
        static let blue = "Blue"
        
        static let titleColor: UIColor = .white
        static let descriptionColor: UIColor = .white
        static let wish1Color: UIColor = .white
        static let wish2Color: UIColor = .white
        static let wish3Color: UIColor = .white
        static let buttonColor: UIColor = .darkGray
        
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
    }
    
    // MARK: Views
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    
    private let wish1View = UILabel()
    private let stackView = UIStackView()
    private let slidersButton = UIButton(type: .system)
    private let or1TitleView = UILabel()
    private let or2TitleView = UILabel()
    private let hexColorTextField = UITextField()
    private let sendColorButton = UIButton()
    private let randomButton = UIButton(type: .roundedRect)
    
    private let wish2View = UILabel()
    private let wish3View = UILabel()
    
    // MARK: Button related variables
    var slidersHidden: Bool = false
    
    // MARK: RGB values
    private var redValue: Double = 0.5
    private var blueValue: Double = 0.5
    private var greenValue: Double = 0.5
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI configuration functions
    private func configureUI() {
        updateBackground()

        configureTitle()
        configureDescription()
        
        configureWish1Text()
        configureSlidersButton()
        configureSliders()
        configureOr1Text()
        configureHexInput()
        configureSendColorButton()
        configureOr2Text()
        configureRandomButton()
    }
    
    // MARK: Title and description configuration
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = constants.titleText
        titleView.font = UIFont.systemFont(ofSize: constants.titleFontSize)
        titleView.textColor = constants.titleColor
        
        view.addSubview(titleView)
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinLeft(to: view, 20)
        titleView.pinTop(to: view, 50)
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionView.text = constants.descriptionText
        descriptionView.font = UIFont.boldSystemFont(ofSize: constants.descriptionFontSize)
        descriptionView.textColor = constants.descriptionColor
        descriptionView.numberOfLines = constants.descriptionNumberOfLines
        
        view.addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: view.centerXAnchor)
        descriptionView.pinLeft(to: view, 20)
        descriptionView.pinTop(to: titleView.bottomAnchor, 20)
    }
    
    // MARK: Wish1 configuration
    
    // MARK: TextViews
    private func configureWish1Text() {
        wish1View.translatesAutoresizingMaskIntoConstraints = false
        
        wish1View.text = constants.wish1Text
        wish1View.font = UIFont.boldSystemFont(ofSize: constants.wishFontSize)
        wish1View.textColor = constants.wish1Color
        
        view.addSubview(wish1View)

        wish1View.pinCenterX(to: view.centerXAnchor)
        wish1View.pinLeft(to: view, 20)
        wish1View.pinTop(to: descriptionView.bottomAnchor, 20)
    }
    
    // MARK: Buttons
    func configureSlidersButton() {
        slidersButton.translatesAutoresizingMaskIntoConstraints = false
        
        slidersButton.setTitle(constants.hideSlidersButtonText, for: .normal)
        slidersButton.backgroundColor = constants.buttonColor
        slidersButton.layer.cornerRadius = constants.buttonCornerRadius
        
        view.addSubview(slidersButton)

        slidersButton.pinCenterX(to: view.centerXAnchor)
        slidersButton.pinLeft(to: view, 50)
        slidersButton.pinTop(to: wish1View.bottomAnchor, 20)
        
        slidersButton.addTarget(self, action: #selector(slidersButtonPressed), for: .touchUpInside)
    }
    
    private func configureSendColorButton() {
        sendColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        sendColorButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        
        view.addSubview(sendColorButton)
        
        sendColorButton.pinCenterX(to: view.centerXAnchor)
        sendColorButton.pinLeft(to: hexColorTextField, constants.sendColorButtonLeftConst)
        sendColorButton.pinTop(to: hexColorTextField.topAnchor, constants.sendColorButtonTopConst)
        
        sendColorButton.addTarget(self, action: #selector(sendColorButtonPressed), for: .touchUpInside)
    }
    
    private func configureRandomButton() {
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        
        randomButton.layer.cornerRadius = constants.buttonCornerRadius
        randomButton.setTitle(constants.randomButtonText, for: .normal)
        randomButton.backgroundColor = constants.buttonColor
        
        view.addSubview(randomButton)
        
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinLeft(to: view, 60)
        randomButton.pinTop(to: or2TitleView.bottomAnchor, 10)
        
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    //MARK: Sliders
    private func configureSliders() {
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
    
        let sliderRed = CustomSlider(title: constants.red, min: constants.minSliderValue, max: constants.maxSliderValue)
        let sliderBlue = CustomSlider(title: constants.blue, min: constants.minSliderValue, max: constants.maxSliderValue)
        let sliderGreen = CustomSlider(title: constants.green, min: constants.minSliderValue, max: constants.maxSliderValue)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stackView.addArrangedSubview(slider)
        }

        stackView.pinCenterX(to: view.centerXAnchor)
        stackView.pinLeft(to: view.leadingAnchor, 20)
        stackView.pinTop(to: slidersButton.bottomAnchor, 20)
        
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
    
    private func configureOr1Text() {
        or1TitleView.translatesAutoresizingMaskIntoConstraints = false
        
        or1TitleView.textColor = .white
        or1TitleView.text = "Or"
        
        view.addSubview(or1TitleView)
        
        or1TitleView.pinCenterX(to: view.centerXAnchor)
        or1TitleView.pinLeft(to: view, 190)
        or1TitleView.pinTop(to: stackView.bottomAnchor, 10)

    }
    
    // MARK: Hex input
    private func configureHexInput() {
        hexColorTextField.translatesAutoresizingMaskIntoConstraints = false
        
        hexColorTextField.placeholder = "Enter color in hex"
        hexColorTextField.borderStyle = .roundedRect
        hexColorTextField.layer.cornerRadius = 10
        hexColorTextField.backgroundColor = .white
        hexColorTextField.textColor = .black
        hexColorTextField.font = UIFont.systemFont(ofSize: 16)
        
        view.addSubview(hexColorTextField)
        
        hexColorTextField.pinCenterX(to: view.centerXAnchor)
        hexColorTextField.pinLeft(to: view, 50)
        hexColorTextField.pinTop(to: or1TitleView.bottomAnchor, 10)
        
        hexColorTextField.delegate = self
    }
    
    private func configureOr2Text() {
        or2TitleView.translatesAutoresizingMaskIntoConstraints = false
        
        or2TitleView.textColor = .white
        or2TitleView.text = "Or"
        
        view.addSubview(or2TitleView)
        
        or2TitleView.pinCenterX(to: view.centerXAnchor)
        or2TitleView.pinLeft(to: view, 190)
        or2TitleView.pinTop(to: hexColorTextField.bottomAnchor, 10)
    }
    
    // MARK: Auxilary functions for wishes
    // updateBackground function to change bg color for wish 1
    func updateBackground(hexcolor: String = "") {
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
        redValue = Double.random(in: 0...1)
        blueValue = Double.random(in: 0...1)
        greenValue = Double.random(in: 0...1)
        
        updateBackground()
    }
}

