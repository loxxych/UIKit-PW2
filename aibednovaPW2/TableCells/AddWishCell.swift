//
//  AddWishCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 06.11.2025.
//
import UIKit

final class AddWishCell: UITableViewCell {
    let textView: UITextView = UITextView()
    let sendButton: UIButton = UIButton(type: .system)
    
    // MARK: Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
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
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wrap.addSubview(textView)
        textView.pinVertical(to: wrap)
        
        wrap.addSubview(sendButton)
        sendButton.pinCenter(to: wrap)
        sendButton.setTitle("Добавить", for: .normal)
        
    }
    
    /*var addWish: ((String) ->
                  ())? {
        
    }*/
}
