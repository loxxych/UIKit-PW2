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
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: Constants.titleFontSize, weight: .bold)
        static let textFont: UIFont = .monospacedSystemFont(ofSize: Constants.textFontSize, weight: .regular)
        
        static let textFontSize: CGFloat = 17
        static let titleFontSize: CGFloat = 32
        static let descriptionNumberOfLines = 4

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
        titleView.font = Constants.titleFont
        titleView.textColor = Constants.titleTextColor
        titleView.textAlignment = .center
        
        descriptionView.text = description
        descriptionView.font = Constants.textFont
        descriptionView.textColor = Constants.descriptionTextColor
        descriptionView.numberOfLines = Constants.descriptionNumberOfLines
        
        let stack = UIStackView(arrangedSubviews: [titleView, descriptionView])
        
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        
        addSubview(stack)
        
        stack.pinTop(to: self, 20)
        stack.pinHorizontal(to: self, 20)
        stack.pinBottom(to: self, 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
}
