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
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let wrapHeight: CGFloat = 120
        static let wrapCornerRadius: CGFloat = 15
        static let titleLeft: CGFloat = 15
        static let titleTop: CGFloat = 15
        static let pickerLeft: CGFloat = 15
        static let pickerTop: CGFloat = 7
        
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
        fatalError("init(coder:) has not been implemented")
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
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")

        datePicker.setHeight(40)
        datePicker.pinTop(to: titleLabel.bottomAnchor, Constants.pickerTop)
        datePicker.pinLeft(to: wrapView.leadingAnchor, Constants.pickerLeft)
    }
    
    // MARK: - Utility
    func getDate() -> Date {
        return datePicker.date
    }
    
    func setDate(_ date: Date) {
        datePicker.date = date
    }
}

