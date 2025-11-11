//
//  WishTitleView.swift
//  aibednovaPW2
//
//  Created by loxxy on 10.11.2025.
//

import UIKit

final class WishTitleView : UIView {
    // MARK: - Constants
    enum Constants {
        // Strings
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // UI Constraint properties
        static let stackViewIndent: CGFloat = 20
        static let stackViewSpacing: CGFloat = 17
        static let stackAxis: NSLayoutConstraint.Axis = .vertical
        static let alignment: UIStackView.Alignment = .center
        
        // Fonts
        static let textFontSize: CGFloat = 17
        static let titleFontSize: CGFloat = 32
        static let descriptionNumberOfLines = 4
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: Constants.titleFontSize, weight: .bold)
        static let textFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .regular)
        
        // Colors
        static let titleTextColor: UIColor = .white
        static let descriptionTextColor: UIColor = .white
    }
    
    // MARK: - Fields
    private let titleView: UILabel = UILabel()
    private let descriptionView: UILabel = UILabel()
    
    // MARK: - Lifecycle
    init(title: String, description: String) {
        super.init(frame: .zero)
        
        titleView.text = title
        descriptionView.text = description
        
        titleView.text = title
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureStackView()
    }
    
    private func configureTitle() {
        titleView.font = Constants.titleFont
        titleView.textColor = Constants.titleTextColor
        titleView.textAlignment = .center
    }
    
    private func configureDescription() {
        descriptionView.font = Constants.textFont
        descriptionView.textColor = Constants.descriptionTextColor
        descriptionView.numberOfLines = Constants.descriptionNumberOfLines
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [titleView, descriptionView])
        
        stack.axis = Constants.stackAxis
        stack.spacing = Constants.stackViewSpacing
        stack.alignment = Constants.alignment
        
        addSubview(stack)
        
        stack.pinTop(to: self, Constants.stackViewIndent)
        stack.pinHorizontal(to: self, Constants.stackViewIndent)
        stack.pinBottom(to: self, Constants.stackViewIndent)
    }
}
