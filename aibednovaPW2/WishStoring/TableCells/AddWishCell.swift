//
//  AddWishCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//
import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Fields
    static let reuseId: String = Constants.id
    
    let textView: UITextView = UITextView()
    let sendButton: UIButton = UIButton()
    let wrap: UIView = UIView()
    var addWish: ((String) -> ())?
    
    // MARK: Constants
    private enum Constants {
        static let id: String = "AddWishCell"
        static let textViewText: String = "Введите желание"
        
        static let wrapColor: UIColor = .white
        static let textViewColor: UIColor = .lightGray
        
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let textViewRadius: CGFloat = 8
        static let textViewLeftIndent: CGFloat = 3
        static let textViewHeight: CGFloat = 30
        static let sendButtonWidth: CGFloat = 30
        static let sendButtonCornerRadius: CGFloat = 15
        
        static let elementSpacing: CGFloat = 8
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        configureWrap()
        configureSendButton()
        configureTextView()
    }
    
    private func configureWrap() {
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wrap.addSubview(textView)
        wrap.addSubview(sendButton)
    }
    
    private func configureTextView() {
        textView.backgroundColor = Constants.textViewColor
        textView.layer.cornerRadius = Constants.textViewRadius
        textView.font = .systemFont(ofSize: 16)
        textView.accessibilityHint = Constants.textViewText
        
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.pinTop(to: wrap, Constants.elementSpacing)
        textView.pinLeft(to: wrap, Constants.elementSpacing)
        textView.pinBottom(to: wrap, Constants.elementSpacing)
        textView.pinRight(to: sendButton.leadingAnchor, Constants.elementSpacing)
        textView.setHeight(Constants.textViewHeight)
    }
    
    private func configureSendButton() {
        sendButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.tintColor = .white
        
        sendButton.pinRight(to: wrap, Constants.elementSpacing)
        sendButton.backgroundColor = .systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.layer.cornerRadius = Constants.sendButtonCornerRadius
        sendButton.isUserInteractionEnabled = true
        sendButton.isUserInteractionEnabled = true
        
        sendButton.pinTop(to: wrap, Constants.elementSpacing)
        sendButton.pinRight(to: wrap, Constants.elementSpacing)
        sendButton.pinBottom(to: wrap, Constants.elementSpacing)
        sendButton.setWidth(Constants.sendButtonWidth)
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button functions
    @objc
    private func sendButtonTapped() {
        let wishText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !wishText.isEmpty && wishText != Constants.textViewText else {
            return
        }

        addWish?(wishText)

        textView.text = ""
        textView.resignFirstResponder()
    }
}
