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
        static let startDateTitle: String = "Start Date"
        static let endDateTitle: String = "End Date"
        static let orText: String = "or"
        static let chooseButtonText: String = "Choose from saved wishes"
        static let saveButtonText: String = "Save"

        // UI Constraint properties
        static let spacing: CGFloat = 30
        static let saveButtonWidth: CGFloat = 100
        static let saveButtonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 10
        
        // Colors
        static let chooseButtonColor: UIColor = .darkGray
        static let chooseButtontextColor: UIColor = .white
    }
    
    // MARK: - Fields
    private var titleTextField: TitleTextField = .init()
    private var descriptionTextField: DescriptionTextField = .init()
    private let buttonContainer = UIView()
    private var saveButton: UIButton = .init(type: .system)
    private let startDateField: DatePickerField = DatePickerField(title: Constants.startDateTitle)
        private let endDateField: DatePickerField = DatePickerField(title: Constants.endDateTitle)
    private let orLabel: UILabel = UILabel()
    private let chooseWishButton: UIButton = .init(type: .roundedRect)
    private var stackView: UIStackView = UIStackView()
    
    var saveEvent: ((WishEventModel) -> Void)?
    var showChooseWishScreen: (() -> Void)?
    
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
        onfigureOrLabel()
        configureChooseWishButton()
        configureStackView()
    }
    
    // MARK: - Save button configuration
    private func configureSaveButton() {
        buttonContainer.addSubview(saveButton)

        saveButton.pinCenter(to: buttonContainer)

        saveButton.setTitle(Constants.saveButtonText, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        
        saveButton.setWidth(Constants.saveButtonWidth)
        saveButton.setHeight(Constants.saveButtonHeight)
        buttonContainer.setWidth(Constants.saveButtonWidth)
        buttonContainer.setHeight(Constants.saveButtonHeight)
        
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Or label configuration
    private func onfigureOrLabel() {
        orLabel.text = Constants.orText
        orLabel.textAlignment = .center
        orLabel.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    // MARK: - Choose wish button configuration
    private func configureChooseWishButton() {
        chooseWishButton.backgroundColor = Constants.chooseButtonColor
        chooseWishButton.setTitle(Constants.chooseButtonText, for: .normal)
        chooseWishButton.setTitleColor(Constants.chooseButtontextColor, for: .normal)
        chooseWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        
        chooseWishButton.addTarget(self, action: #selector(chooseButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Stack view configuration
    private func configureStackView() {
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing

        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(orLabel)
        stackView.addArrangedSubview(chooseWishButton)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(startDateField)
        stackView.addArrangedSubview(endDateField)
        stackView.addArrangedSubview(buttonContainer)

        stackView.pin(to: self)
    }
    
    // MARK: - Button press functions
    @objc private func saveButtonPressed() {
        let title: String = titleTextField.getTextInput()
        let description: String = descriptionTextField.getTextInput()
        let startDate = startDateField.getDate()
        let endDate = endDateField.getDate()
        
        let eventModel: WishEventModel = WishEventModel(title: title, description: description, startDate: startDate, endDate: endDate)
        
        titleTextField.clear()
        descriptionTextField.clear()
        
        saveEvent?(eventModel)
    }
    
    @objc private func chooseButtonPressed() {
        showChooseWishScreen?()
    }
    
    // MARK: - Utility
    func updateTitleInput(newTitle: String) {
        titleTextField.updateTitleInput(newTitle: newTitle)
    }
}
