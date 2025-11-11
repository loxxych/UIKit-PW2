//
//  ColorSliderStackView.swift
//  aibednovaPW2
//
//  Created by loxxy on 10.11.2025.
//

import UIKit

final class ColorSliderStackView : UIView {
    // MARK: - Constants
    enum Constants {
        // Numbers
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
        static let stackCornerRadius: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 10
        static let alignment: UIStackView.Alignment = .center
        
        // UI Constraint properties
        static let elementSpacing: CGFloat = 8
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 30
        static let stackWidth: CGFloat = 380
        static let horizontalIndent: CGFloat = 20
        
        // Strings
        static let red = "Red"
        static let green = "Green"
        static let blue = "Blue"
        static let hideSlidersButtonText = "Hide sliders"
        static let showSlidersButtonText = "Show sliders"
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // Colors
        static let buttonColor: UIColor = .darkGray
        static let textColor: UIColor = .white
    }
    
    // MARK: - Fields
    // Sliders
    private let sliders: CustomSlidersView = CustomSlidersView()
    
    // Buttons
    private let slidersButton = UIButton(type: .system)
    
    // Closures
    var redValueChanged: ((Double) -> Void)?
    var greenValueChanged: ((Double) -> Void)?
    var blueValueChanged: ((Double) -> Void)?
    var slidersButtonActivate: (() -> ())?
    
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
        configureSlidersButton()
        configureStackView()
        
        connectActions()
    }
    
    func configureSlidersButton() {
        slidersButton.setTitle(Constants.hideSlidersButtonText, for: .normal)
        slidersButton.titleLabel?.textColor = Constants.textColor
        slidersButton.backgroundColor = Constants.buttonColor
        slidersButton.layer.cornerRadius = Constants.buttonCornerRadius
        slidersButton.addTarget(self, action: #selector(slidersButtonPressed), for: .touchUpInside)
        
        slidersButton.setHeight(Constants.buttonHeight)
        slidersButton.setWidth(Constants.buttonWidth)
        slidersButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
    func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [slidersButton, sliders])
        
        stack.axis = .vertical
        stack.clipsToBounds = true
        stack.spacing = Constants.elementSpacing
        
        addSubview(stack)
        
        // Stack constraints
        stack.pinTop(to: self)
        stack.setWidth(Constants.stackWidth)
        stack.pinHorizontal(to: self, Constants.horizontalIndent)
        stack.pinBottom(to: self)
        stack.alignment = Constants.alignment
    }
    
    // MARK: - Action connection
    func connectActions() {
        sliders.redValueChanged = redValueChanged
        sliders.greenValueChanged = greenValueChanged
        sliders.blueValueChanged = blueValueChanged
        
        sliders.bindSliders()
    }
    
    // MARK: - Button press functions
    @objc func slidersButtonPressed() {
        slidersButtonActivate?()
    }
    
    // MARK: - Display logic
    func setSliders(red: Double, green: Double, blue: Double) {
        sliders.setSliders(red: red, green: green, blue: blue)
    }
    
    func setHidden(_ hidden: Bool) {
        sliders.setHidden(hidden)
    }
    
}
