//
//  HexTextField.swift
//  aibednovaPW2
//
//  Created by loxxy on 11.11.2025.
//

import UIKit

final class HexTextField : UIView, UITextFieldDelegate {
    // MARK: - Constants
    enum Constants {
        // Constraint properties
        static let elementSpacing: CGFloat = 10
        static let stackAxis: NSLayoutConstraint.Axis = .horizontal
        static let buttonSize: CGFloat = 20
        
        // String
        static let hexTextFieldText = "Enter color in hex"
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let defaultText: String = ""
        
        // Fonts
        static let textFieldFont: UIFont = .systemFont(ofSize: Constants.textFontSize)
        static let textFontSize: CGFloat = 17
        static let textFieldBorderStyle: UITextField.BorderStyle = .roundedRect
        
        // Colors
        static let buttonColor: UIColor = .darkGray
        static let textFieldColor: UIColor = .white
        static let textFieldTextColor: UIColor = .black
        
        // Images
        static let sendButtonImage: UIImage? = UIImage(systemName: "arrow.right.circle.fill")
    }
    
    // MARK: - Fields
    // Text fields
    private let hexTextField = UITextField()
    
    // Buttons
    private let sendColorButton = UIButton()
    
    // Closures
    var onSendHex: ((String) -> ())?
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureTextField()
        configureHexSendButton()
        configureStackView()
    }
    
    private func configureTextField() {
        hexTextField.placeholder = Constants.hexTextFieldText
        hexTextField.borderStyle = Constants.textFieldBorderStyle
        hexTextField.backgroundColor = Constants.textFieldColor
        hexTextField.textColor = Constants.textFieldTextColor
        hexTextField.font = Constants.textFieldFont
        hexTextField.delegate = self
    }
    
    private func configureHexSendButton() {
        sendColorButton.setImage(Constants.sendButtonImage, for: .normal)
        
        sendColorButton.addTarget(self, action: #selector(sendColorButtonPressed), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [hexTextField, sendColorButton])
        stack.axis = Constants.stackAxis
        stack.spacing = Constants.elementSpacing
        
        addSubview(stack)
        
        isUserInteractionEnabled = true
        
        stack.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - Button press functions
    @objc func sendColorButtonPressed() {
        onSendHex?(hexTextField.text ?? Constants.defaultText)
    }
}
