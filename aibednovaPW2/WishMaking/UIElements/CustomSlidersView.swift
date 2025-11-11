//
//  CustomSlidersView.swift
//  aibednovaPW2
//
//  Created by loxxy on 11.11.2025.
//

import UIKit

final class CustomSlidersView : UIView {
    // MARK: - Constants
    enum Constants {
        // Numbers
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
        static let stackCornerRadius: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 5
        
        // UI Constraint properties
        static let elementSpacing: CGFloat = 8
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 30
        static let stackWidth: CGFloat = 380
        
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
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.minSliderValue, max: Constants.maxSliderValue)
    
    // Closures
    var redValueChanged: ((Double) -> Void)?
    var greenValueChanged: ((Double) -> Void)?
    var blueValueChanged: ((Double) -> Void)?
    
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
        // Configuring stackView
        let stack = UIStackView(arrangedSubviews: [sliderRed, sliderGreen, sliderBlue])
        
        stack.axis = .vertical
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        stack.spacing = Constants.elementSpacing
        
        addSubview(stack)
        
        stack.pinTop(to: self)
        stack.setWidth(Constants.stackWidth)
        stack.pinHorizontal(to: self, 20)
        stack.pinBottom(to: self)
        
        sliderRed.setWidth(Constants.stackWidth)
        
        bindSliders()
    }
    
    func bindSliders() {
        sliderRed.valueChanged = redValueChanged
        sliderGreen.valueChanged = greenValueChanged
        sliderBlue.valueChanged = blueValueChanged
    }

    // MARK: - Display logic
    func setSliders(red: Double, green: Double, blue: Double) {
        sliderRed.sliderValue = red
        sliderGreen.sliderValue = green
        sliderBlue.sliderValue = blue
    }

    func setHidden(_ hidden: Bool) {
        sliderRed.isHidden = hidden
        sliderGreen.isHidden = hidden
        sliderBlue.isHidden = hidden
    }

}
