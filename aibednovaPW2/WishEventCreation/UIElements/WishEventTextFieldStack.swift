//
//  WishEventTextFieldStack.swift
//  aibednovaPW2
//
//  Created by loxxy on 19.01.2026.
//

import UIKit

class WishEventTextFieldStack : UIView {
    // MARK: - Constants
    private enum Constants {
        // Text
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // UI Constraint properties
        static let spacing: CGFloat = 30
        static let saveButtonWidth: CGFloat = 100
        static let saveButtonHeight: CGFloat = 40
    }
    
    // MARK: - Fields
    private var titleTextField: TitleTextField = .init()
    private var descriptionTextField: DescriptionTextField = .init()
    private let buttonContainer = UIView()
    private var saveButton: UIButton = .init(type: .system)
    private var stackView: UIStackView = UIStackView()
    
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
        configureSaveButton()
        configureStackView()
    }
    
    // MARK: - Save button configuration
    private func configureSaveButton() {
        buttonContainer.addSubview(saveButton)

        saveButton.pinCenter(to: buttonContainer)

        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        
        saveButton.setWidth(Constants.saveButtonWidth)
        saveButton.setHeight(Constants.saveButtonHeight)

    }
    
    // MARK: - Stack view configuration
    private func configureStackView() {
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing

        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(buttonContainer)

        stackView.pin(to: self)
    }
}
