//
//  Wish1View.swift
//  aibednovaPW2
//
//  Created by loxxy on 10.11.2025.
//

import UIKit

final class Wish1View : UIView {
    // MARK: - Constants
    enum Constants {
        // Numbers
        static let stackCornerRadius: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 10
        static let stackAlignment: UIStackView.Alignment = .center
        static let stackIndent: CGFloat = 20
        
        // UI constraint properties
        static let elementSpacing: CGFloat = 10
        static let buttonWidth: CGFloat = 150
        static let stackAxis: NSLayoutConstraint.Axis = .vertical
        
        // Strings
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let orText = "Or"
        static let descriptionText = "· Change bg color:"
        static let randomButtonText = "Random color"
        
        // Fonts
        static let textFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .regular)
        static let textFontSize: CGFloat = 17
        
        // Colors
        static let textColor: UIColor = .white
        static let buttonColor: UIColor = .lightGray
    }
    
    // MARK: - Fields
    // Labels
    private let descriptionView: UILabel = UILabel()
    private let or1View: UILabel = UILabel()
    private let or2View: UILabel = UILabel()
    
    // Text fields
    private let hexTextField = HexTextField()
    
    // Buttons
    public let randomButton = UIButton(type: .roundedRect)
    
    // Color values
    private var currentRed: Double = 0
    private var currentGreen: Double = 0
    private var currentBlue: Double = 0
    
    // Closures
    var onRandomButtonPressed: (() -> ())?
    var onColorChanged: ((_ red: Double?, _ green: Double?, _ blue: Double?) -> ())?
    var onSendHex: ((String) -> ())?
    var onSlidersToggle: (() -> ())?
    
    // Stacks
    private var colorSliders: ColorSliderStackView = ColorSliderStackView()
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureDescriptionView()
        configureOrViews()
        configureRandomButton()
        configureStackView()
        
        // Random button constraints
        randomButton.setWidth(Constants.buttonWidth)
        
        connectActions()
    }
    
    // MARK: - Description configuration
    private func configureDescriptionView() {
        descriptionView.text = Constants.descriptionText
        descriptionView.font = Constants.textFont
        descriptionView.textColor = Constants.textColor
    }
    
    // MARK: - Or views configuration
    private func configureOrViews() {
        or1View.textColor = Constants.textColor
        or1View.text = Constants.orText
        or1View.font = Constants.textFont
        or2View.textColor = Constants.textColor
        or2View.text = Constants.orText
        or2View.font = Constants.textFont
    }
    
    // MARK: - Random button configuration
    private func configureRandomButton() {
        randomButton.layer.cornerRadius = Constants.buttonCornerRadius
        randomButton.setTitle(Constants.randomButtonText, for: .normal)
        randomButton.titleLabel?.textColor = Constants.textColor
        randomButton.backgroundColor = Constants.buttonColor
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Stack configuration
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [descriptionView, colorSliders, or1View, hexTextField, or2View, randomButton])
        
        stack.axis = Constants.stackAxis
        stack.spacing = Constants.elementSpacing
        stack.alignment = Constants.stackAlignment
        
        addSubview(stack)
        
        stack.isUserInteractionEnabled = true
        
        // Stack view constraints
        stack.pinCenterX(to: self)
        stack.pinTop(to: self, Constants.stackIndent)
        stack.pinLeft(to: self, Constants.stackIndent)
        stack.pinRight(to: self, Constants.stackIndent)
        stack.pinBottom(to: self, Constants.stackIndent)
    }
    
    // MARK: - Actions connection
    private func connectActions() {
        hexTextField.onSendHex = { [weak self] hex in self?.onSendHex?(hex) }
        
        colorSliders.slidersButtonActivate = { [weak self] in self?.onSlidersToggle?() }
        
        colorSliders.redValueChanged = { [weak self] value in
            self?.currentRed = value
            self?.onColorChanged?(value, nil, nil) }
        
        colorSliders.greenValueChanged = { [weak self] value in
            self?.currentGreen = value
            self?.onColorChanged?(nil, value, nil) }
        
        colorSliders.blueValueChanged = { [weak self] value in
            self?.currentBlue = value
            self?.onColorChanged?(nil, nil, value) }
        
        colorSliders.connectActions()
    }
    
    // MARK: - Button press functions
    @objc private func randomButtonPressed() {
        onRandomButtonPressed?()
    }
    
    // MARK: - Display logic
    func updateSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
        colorSliders.setSliders(red: red, green: green, blue: blue)
    }
    
    func toggleSliders(isHidden: Bool) {
        colorSliders.setHidden(isHidden)
    }
    
}
