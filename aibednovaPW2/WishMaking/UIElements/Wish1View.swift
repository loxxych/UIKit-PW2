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
        
        // Constraint properties
        static let elementSpacing: CGFloat = 10
        static let buttonWidth: CGFloat = 150
        
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
        static let buttonColor: UIColor = .darkGray
    }
    
    // MARK: - Fields
    // UI elements
    private let descriptionView: UILabel = UILabel()
    private let or1View: UILabel = UILabel()
    private let or2View: UILabel = UILabel()
    private let hexTextField = HexTextField()
    
    // Buttons
    public let randomButton = UIButton(type: .roundedRect)
    
    // Color values
    private var currentRed: Double = 0
    private var currentGreen: Double = 0
    private var currentBlue: Double = 0
    
    // Closures
    var randomButtonActivate: (() -> ())?
    var onColorChanged: ((_ red: Double?, _ green: Double?, _ blue: Double?) -> ())?
    var onSendHex: ((String) -> ())?
    var onSlidersToggle: (() -> ())?
    
    // Stacks
    private var colorSliders: ColorSliderStackView = ColorSliderStackView()
    
    // MARK: - Lifecycle
    init(description: String) {
        super.init(frame: .zero)
        
        // Configuring wish description
        descriptionView.text = Constants.descriptionText
        descriptionView.font = Constants.textFont
        descriptionView.textColor = Constants.textColor
        
        // Configuring "or" labels
        or1View.textColor = Constants.textColor
        or1View.text = Constants.orText
        or1View.font = Constants.textFont
        or2View.textColor = Constants.textColor
        or2View.text = Constants.orText
        or2View.font = Constants.textFont
        
        // Configuring random button
        randomButton.layer.cornerRadius = Constants.buttonCornerRadius
        randomButton.setTitle(Constants.randomButtonText, for: .normal)
        randomButton.backgroundColor = Constants.buttonColor
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [descriptionView, colorSliders, or1View, hexTextField, or2View, randomButton])
        
        stack.axis = .vertical
        stack.spacing = Constants.elementSpacing
        stack.alignment = .center
        
        addSubview(stack)
        
        stack.isUserInteractionEnabled = true

        stack.pinCenterX(to: self)
        stack.pinTop(to: self, 20)
        stack.pinLeft(to: self, 20)
        stack.pinRight(to: self, 20)
        stack.pinBottom(to: self, 20)
        
        randomButton.setWidth(Constants.buttonWidth)
        connectActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    private func connectActions() {
        colorSliders.redValueChanged = { [weak self] value in
            self?.currentRed = value
            self?.onColorChanged?(value, nil, nil) }
        colorSliders.greenValueChanged = { [weak self] value in
            self?.currentGreen = value
            self?.onColorChanged?(nil, value, nil) }
        colorSliders.blueValueChanged = { [weak self] value in
            self?.currentBlue = value
            self?.onColorChanged?(nil, nil, value) }
        colorSliders.slidersButtonActivate = { [weak self] in self?.onSlidersToggle?() }
        
        colorSliders.bindSliders()
        
        hexTextField.onSendHex = { [weak self] hex in self?.onSendHex?(hex) }
    }
    
    // MARK: - Button press functions
    @objc private func randomButtonPressed() {
        randomButtonActivate?()
    }
    
    // MARK: - Display logic
    func updateSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
        colorSliders.setSliders(red: red, green: green, blue: blue)
    }

    func toggleSliders(isHidden: Bool) {
        colorSliders.setHidden(isHidden)
    }
    
}
