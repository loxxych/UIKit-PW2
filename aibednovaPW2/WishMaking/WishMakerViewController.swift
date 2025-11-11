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
        //static let titleFontSize: CGFloat = 32
        static let textFontSize: CGFloat = 17
        static let animationDuration: CGFloat = 1
        
        /*static let titleFont: UIFont = .monospacedSystemFont(ofSize: Constants.titleFontSize, weight: .bold)
         static let textFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .regular)*/
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
        static let elementSpacing: CGFloat = 10
        //static let descriptionNumberOfLines = 3
        
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
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        static let sendButtonImage: UIImage? = UIImage(systemName: "arrow.right.circle.fill")
        
        //static let titleTextColor: UIColor = .white
        //static let descriptionTextColor: UIColor = .white
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
    
    // Custom views
    private let titleView = WishTitleView(title: Constants.titleText, description: Constants.descriptionText)
    private lazy var wish1View: Wish1View = {
        let view = Wish1View(description: Constants.wish1Text)
        return view
    }()
    
    // Text fields
    private let hexColorTextField = UITextField()
    
    // Stacks
    private let stackView = UIStackView()
    
    // Buttons
    private let addWishButton = UIButton(type: .roundedRect)
    
    // Utility variables
    var slidersHidden: Bool = false
    
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
        
        configureAddWishButton()
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        view.addSubview(titleView)
        
        titleView.pinTop(to: view.topAnchor, Constants.titleTopIndent)
        titleView.pinHorizontal(to: view, Constants.titleLeftIndent)
    }
    
    // MARK: - Wish 1 configuration
    private func configureWish1() {
        wish1View = Wish1View(description: Constants.wish1Text)
        
        wish1View.onColorChanged = { [weak self] red, green, blue in
            self?.interactor.updateColor(.init(red: red, green: green, blue: blue))
        }
        
        wish1View.randomButtonActivate = { [weak self] in
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
        wish1View.pinHorizontal(to: view, 20)
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
        addWishButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(addWishButton)
        
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinBottom(to: view.bottomAnchor, Constants.addWishButtonBottomIndent)
        addWishButton.pinLeft(to: view.leadingAnchor, Constants.addWishButtonLeftIndent)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Button press functions
    /*func slidersButtonPressed() {
        interactor.toggleSliders(Model.ToggleSliders.Request())
    }
    
    func sendColorButtonPressed() {
        let hex = hexColorTextField.text ?? ""
        interactor.updateColor(Model.ColorUpdate.Request(hex: hex))
    }
    
    func randomButtonPressed() {
        interactor.generateRandomColor(Model.RandomColor.Request())
    }*/
    
    @objc func addWishButtonPressed() {
        interactor.showAddWishViewController(Model.ShowAddWishViewController.Request())
    }
    
    // MARK: - Display logic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        // Change background color to init rgb values
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Sets background to given color
    func displayColorUpdate(_ viewModel: Model.ColorUpdate.ViewModel) {
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
    // Hides or shows sliders
    func displayToggleSliders(_ viewModel: Model.ToggleSliders.ViewModel) {
        wish1View.toggleSliders(isHidden: viewModel.isHidden)
    }
    
    // Sets background to given random color
    func displayRandomColor(_ viewModel: Model.RandomColor.ViewModel) {
        changeBackground(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
        wish1View.updateSliders(red: viewModel.red, green: viewModel.green, blue: viewModel.blue)
    }
    
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
    
    /*func displayStart(_ viewModel: Model.Start.ViewModel) {
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
     //slidersButton.setTitle(viewModel.buttonTitle, for: .normal)
     }
     
     // Sets background to given random color
     func displayRandomColor(_ viewModel: Model.RandomColor.ViewModel) {
     displayColorUpdate(Model.ColorUpdate.ViewModel(red: viewModel.red, green: viewModel.green, blue: viewModel.blue))
     }
     
     // MARK: - Utility functions
     private func changeBackgroundAndSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
     //randomButton.isEnabled = false
     //        UIView.animate(
     //            withDuration: Constants.animationDuration,
     //            animations: {
     //                self.view.backgroundColor = UIColor(
     //                    red: red,
     //                    green: green,
     //                    blue: blue,
     //                    alpha: Constants.alpha
     //                )
     //            },
     //            completion: { [weak self] _ in
     //                //self?.randomButton.isEnabled = true
     //            }
     //        )
     
     //        sliderRed.sliderValue = red
     //        sliderGreen.sliderValue = green
     //        sliderBlue.sliderValue = blue
     }*/
}

