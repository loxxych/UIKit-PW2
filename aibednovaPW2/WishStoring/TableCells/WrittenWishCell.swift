//
//  WrittenWishCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//
import UIKit

final class WrittenWishCell: UITableViewCell {
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
        static let deleteButtonRightIndent: CGFloat = 8
        static let buttonSize: CGFloat = 24
        static let editButtonRightIndent: CGFloat = 8
        
        // Images
        static let config = UIImage.SymbolConfiguration(weight: .light)
        static let trashImage = UIImage(systemName: "trash", withConfiguration: config)
        static let editImage = UIImage(systemName: "pencil")
        static let checkmarkImage = UIImage(systemName: "checkmark")
    }
    
    // MARK: - Fields
    // Ids
    static let reuseId: String = Constants.id
    
    // Views
    private let wrap: UIView = UIView()
    
    // Labels
    private let wishLabel: UILabel = UILabel()
    
    // Buttons
    private let deleteButton: UIButton = UIButton()
    private let editButton: UIButton = UIButton()
    private let sendButton: UIButton = UIButton()
    
    // Text views
    private let wishTextView: UITextView = UITextView()
    
    // Utility variables
    private var editingMode: Bool = false
    
    // Closures
    private var deleteWish: (() -> ())?
    private var editWish: (() -> ())?
    private var sendWish: ((String) -> ())?
    
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
    func configure(wish: Wish, deleteWish: (() -> ())?, editWish: (() -> ())?, sendWish: ((String) -> ())?) {
        wishLabel.text = wish.wishText
        self.deleteWish = deleteWish
        self.editWish = editWish
        self.sendWish = sendWish
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        configureWrap()
        configureLabel()
        configureDeleteButton()
        configureEditButton()
        configureTextView()
        configureSendButton()
        
        setEditingMode(false)
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
    
    // MARK: - Delete button configuration
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = .red
        
        wrap.addSubview(deleteButton)
        
        isUserInteractionEnabled = true
        
        deleteButton.pinCenterY(to: wrap)
        deleteButton.pinRight(to: wrap, Constants.deleteButtonRightIndent)
        deleteButton.setWidth(Constants.buttonSize)
        deleteButton.setHeight(Constants.buttonSize)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Edit button configuration
    private func configureEditButton() {
        editButton.setImage(Constants.editImage, for: .normal)
        editButton.tintColor = .gray
        
        wrap.addSubview(editButton)
        
        editButton.pinCenterY(to: wrap)
        editButton.pinRight(to: deleteButton.leadingAnchor, Constants.editButtonRightIndent)
        editButton.setWidth(Constants.buttonSize)
        editButton.setHeight(Constants.buttonSize)
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Send button configuration
    private func configureSendButton() {
        sendButton.setImage(Constants.checkmarkImage, for: .normal)
        sendButton.tintColor = .green
        
        wrap.addSubview(sendButton)
        
        sendButton.pinCenterY(to: wrap)
        sendButton.pinRight(to: wrap, Constants.deleteButtonRightIndent)
        sendButton.setWidth(Constants.buttonSize)
        sendButton.setHeight(Constants.buttonSize)
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Wish text configuration
    private func configureTextView() {
        wishTextView.font = .systemFont(ofSize: Constants.textSize)
        wrap.addSubview(wishTextView)
        
        wishTextView.pin(to: wrap, Constants.wishLabelOffset)
    }
    
    // MARK: - Button press functions
    @objc private func deleteButtonTapped() {
        deleteWish?()
    }
    
    @objc private func editButtonTapped() {
        editWish?()
    }
    
    @objc private func sendButtonTapped() {
        sendWish?(wishTextView.text)
    }
    
    // MARK: - Display logic
    public func setEditingMode(_ editingMode: Bool) {
        self.editingMode = editingMode
        
        wishLabel.isHidden = editingMode
        editButton.isHidden = editingMode
        deleteButton.isHidden = editingMode
        
        wishTextView.isHidden = !editingMode
        sendButton.isHidden = !editingMode
        
        if !editingMode {
            wishTextView.text = Constants.textViewDefaultText
        }
    }
    
    func startEditing() {
        setEditingMode(true)
        
        wishTextView.text = wishLabel.text ?? Constants.textViewDefaultText
        wishTextView.becomeFirstResponder()
    }
    
    func finishEditing() {
        setEditingMode(false)
        
        wishTextView.resignFirstResponder()
    }
    
    // MARK: - Utility funcntions
    func getEditedText() -> String? {
        return wishTextView.text
    }
}
