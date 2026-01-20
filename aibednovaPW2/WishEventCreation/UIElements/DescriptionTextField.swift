//
//  DescriptionTextField.swift
//  aibednovaPW2
//
//  Created by loxxy on 19.01.2026.
//

import UIKit

final class DescriptionTextField: UIView {
    // MARK: - Constants
    private enum Constants {
        // Text
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let titleText: String = "Wish description"
        static let textFieldPlaceholder: String = "Enter your wish description"
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let defaultText: String = ""
        
        // UI Constraint properties
        static let wrapHeight: CGFloat = 120
        static let wrapCornerRadius: CGFloat = 15
        static let titleLeft: CGFloat = 15
        static let titleTop: CGFloat = 15
        static let textFieldLeft: CGFloat = 15
        static let textFieldTop: CGFloat = 7
        static let textFieldHeight: CGFloat = 60
        static let textFieldWidth: CGFloat = 300
        static let textFieldCornerRadius: CGFloat = 5
        
        // Colors
        static let wrapColor: UIColor = .systemGray6
        static let textFieldColor: UIColor = .white
    }
    
    // MARK: - Fields
    private var titleLabel: UILabel = .init()
    private var textField: UITextField = .init()
    private var wrapView: UIView = .init()
    
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
        configureWrap()
        configureTitle()
        configureTextField()
    }
    
    // MARK: - Wrap configuration
    private func configureWrap() {
        self.addSubview(wrapView)
        
        wrapView.backgroundColor = Constants.wrapColor
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
  
        wrapView.pin(to: self)
        self.setHeight(Constants.wrapHeight)
    }
    
    // MARK: - Title configuration
    private func configureTitle() {
        wrapView.addSubview(titleLabel)
        
        titleLabel.text = Constants.titleText
        titleLabel.font = Constants.titleFont
        
        titleLabel.pinLeft(to: wrapView.leadingAnchor, Constants.titleLeft)
        titleLabel.pinTop(to: wrapView.topAnchor, Constants.titleTop)
    }
    
    // MARK: - Text field configuration
    private func configureTextField() {
        wrapView.addSubview(textField)
        
        textField.placeholder = Constants.textFieldPlaceholder
        textField.backgroundColor = Constants.textFieldColor
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        
        textField.setWidth(Constants.textFieldWidth)
        textField.setHeight(Constants.textFieldHeight)
        textField.pinTop(to: titleLabel.bottomAnchor, Constants.textFieldTop)
        textField.pinLeft(to: wrapView.leadingAnchor, Constants.textFieldLeft)
    }
    
    // MARK: - Utility functions
    func getTextInput() -> String {
        return textField.text ?? Constants.defaultText
    }
    
    func clear() {
        textField.text = Constants.defaultText
        textField.resignFirstResponder()
    }
    
}
