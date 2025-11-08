//
//  WrittenWishCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//
import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = Constants.id
    
    private enum Constants {
        // Strings
        static let id: String = "WrittenWishCell"
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // Colors
        static let wrapColor: UIColor = .white
        
        // Constraints
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        static let deleteButtonLeftIndent: CGFloat = 8
        static let deleteButtonWidth: CGFloat = 24
        
        // Images
        static let config = UIImage.SymbolConfiguration(weight: .light)
        static let trashImage = UIImage(systemName: "trash", withConfiguration: config)
    }
    
    private let wrap: UIView = UIView()
    private let wishLabel: UILabel = UILabel()
    private let deleteButton: UIButton = UIButton()
    var deleteWish: (() -> ())?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    func configure(wish: String, deleteWish: (() -> ())?) {
        wishLabel.text = wish
        self.deleteWish = deleteWish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        configureWrap()
        configureLabel()
        configureDeleteButton()
    }
    
    private func configureWrap() {
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wrap.addSubview(wishLabel)
    }
    
    private func configureLabel() {
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
    }
    
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = .red
        
        wrap.addSubview(deleteButton)
        
        isUserInteractionEnabled = true

        deleteButton.pinCenterY(to: wrap)
        deleteButton.pinRight(to: wrap, Constants.deleteButtonLeftIndent)
        deleteButton.setWidth(Constants.deleteButtonWidth)
        deleteButton.setHeight(Constants.deleteButtonWidth)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteButtonTapped() {
        deleteWish?()
    }
}
