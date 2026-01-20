//
//  DatePickField.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import UIKit

class DatePickerField: UIView {
    // MARK: - Constants
    private enum Constants {
        // Text
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // UI Constraint properties
        static let wrapHeight: CGFloat = 100
        static let wrapCornerRadius: CGFloat = 15
        static let titleLeft: CGFloat = 15
        static let titleTop: CGFloat = 15
        static let pickerLeft: CGFloat = 15
        static let pickerTop: CGFloat = 7
        static let pickerHeight: CGFloat = 40
        
        // Colors
        static let wrapColor: UIColor = .systemGray6
    }
    
    // MARK: - Fields
    private let titleLabel: UILabel = .init()
    private let datePicker: UIDatePicker = .init()
    private let wrapView: UIView = .init()
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureWrap()
        configureTitle()
        configureDatePicker()
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        
        wrapView.backgroundColor = Constants.wrapColor
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrapView.pin(to: self)
        self.setHeight(Constants.wrapHeight)
    }
    
    private func configureTitle() {
        wrapView.addSubview(titleLabel)
        
        titleLabel.font = Constants.titleFont
        
        titleLabel.pinLeft(to: wrapView.leadingAnchor, Constants.titleLeft)
        titleLabel.pinTop(to: wrapView.topAnchor, Constants.titleTop)
    }
    
    private func configureDatePicker() {
        wrapView.addSubview(datePicker)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        
        datePicker.setHeight(Constants.pickerHeight)
        datePicker.pinTop(to: titleLabel.bottomAnchor, Constants.pickerTop)
        datePicker.pinLeft(to: wrapView.leadingAnchor, Constants.pickerLeft)
    }
    
    // MARK: - Utility
    func getDate() -> Date {
        return datePicker.date
    }
}

