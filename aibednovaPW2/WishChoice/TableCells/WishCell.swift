//
//  WishCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import UIKit

final class WishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        // Numbers
        static let textSize: CGFloat = 17
        
        // Strings
        static let id: String = "WrittenWishCell"
        static let errorMsg: String = "init(coder:) has not been implemented"
        static let textViewDefaultText: String = ""
        
        // Colors
        static let wrapColor: UIColor = .white
        
        // UI constraint properties
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        // Animation properties
        static let animationDuration: CGFloat = 0.8
        static let animationDelay: CGFloat = 0
        static let animationDamping: CGFloat = 0.7
        static let AnimationVelocity: CGFloat = 0.3
    }
    
    // MARK: - Fields
    // Ids
    static let reuseId: String = Constants.id
    
    // Views
    private let wrap: UIView = UIView()
    
    // Labels
    private let wishLabel: UILabel = UILabel()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - Basic configuration
    func configure(wish: Wish) {
        wishLabel.text = wish.wishText
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = .clear

        configureWrap()
        configureLabel()
    }
    
    // MARK: - Wrap configuration
    private func configureWrap() {
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
    }
    
    // MARK: - Label configuration
    private func configureLabel() {
        wishLabel.font = .systemFont(ofSize: Constants.textSize)
        wrap.addSubview(wishLabel)
        
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
    }
}
