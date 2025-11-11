//
//  CustomSlider.swift
//  aibednovaPW2
//
//  Created by loxxy on 21.09.2025.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    enum Constants {
        // Constraint properties
        static let textAlignment: NSTextAlignment = .center
        static let titleViewTopIndent: CGFloat = 10
        static let titleViewLeftIndent: CGFloat = 20
        static let sliderBottomIndent: CGFloat = 10
        static let sliderLeftIndent: CGFloat = 20
        
        // String
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // Colors
        static let backgroundColor: UIColor = .white
    }
    
    // MARK: - Fields
    // UI elements
    var titleView = UILabel()
    
    // Closures
    var valueChanged: ((Double) -> Void)?
    
    // Sliders
    var slider = UISlider()
    
    // Values
    var sliderValue: Double {
        get { Double(slider.value) }
        set { slider.value = Float(newValue) }
    }
    
    // MARK: - Lifecycle
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        
        titleView.text = title
        titleView.textAlignment = Constants.textAlignment
        
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        
        configureTitle()
        configureSlider()
        
    }
    
    private func configureTitle() {
        addSubview(titleView)
        
        titleView.pinCenterX(to: self)
        titleView.pinTop(to: self, Constants.titleViewTopIndent)
        titleView.pinLeft(to: self.leadingAnchor, Constants.titleViewLeftIndent)
    }
    
    private func configureSlider() {
        addSubview(slider)
        
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinCenterX(to: self)
        slider.pinBottom(to: self, Constants.sliderBottomIndent)
        slider.pinLeft(to: self.leadingAnchor, Constants.sliderLeftIndent)
    }
    
    // MARK: - Button press functions
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

