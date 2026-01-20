//
//  WishEventCell.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

final class WishEventCell : UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        // UI constraint properties
        static let offset: CGFloat = 16
        static let titleTop: CGFloat = 8
        static let titleLeading: CGFloat = 8
        static let cornerRadius: CGFloat = 10
        static let descriptionTop: CGFloat = 30
        static let startDateTrailing: CGFloat = 8
        static let startDateTop: CGFloat = 10
        static let endDateBottom: CGFloat = 10
        
        // Text
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let descriptionFont: UIFont = .systemFont(ofSize: 17)
        static let dateFont: UIFont = .systemFont(ofSize: 15)
        static let startDateText: String = "Start Date: "
        static let endDateText: String = "End Date: "
        static let dateFormat: String = "yyyy-MM-dd"
        static let cellIdentifier: String = "WishEventCell"
        static let errorMsg: String = "init(coder:) has not been implemented"
        
        // Colors
        static let backgroundColor: UIColor = .systemGray6
        static let textColor: UIColor = .black
        static let dateTextColor: UIColor = .gray
    }
    
    // MARK: - Fields
    static let reuseIdentifier: String = Constants.cellIdentifier
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMsg)
    }
    
    // MARK: - UI Configurtion
    private func configureUI() {
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrapView)
        
        wrapView.pin(to: contentView, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        
        titleLabel.textColor = Constants.textColor
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        
        descriptionLabel.textColor = Constants.textColor
        descriptionLabel.pinTop(to: titleLabel, Constants.descriptionTop)
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
        descriptionLabel.font = Constants.descriptionFont
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        
        startDateLabel.font = Constants.dateFont
        startDateLabel.textColor = Constants.dateTextColor
        startDateLabel.pinRight(to: wrapView.trailingAnchor, Constants.startDateTrailing)
        startDateLabel.pinTop(to: wrapView, Constants.startDateTop)
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        
        endDateLabel.font = Constants.dateFont
        endDateLabel.textColor = Constants.dateTextColor
        endDateLabel.pinRight(to: wrapView.trailingAnchor, Constants.startDateTrailing)
        endDateLabel.pinBottom(to: wrapView.bottomAnchor, Constants.endDateBottom)
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "\(Constants.startDateText) \(dateFormatter.string(from: event.startDate))"
        endDateLabel.text = "\(Constants.endDateText) \(dateFormatter.string(from: event.endDate))"
    }
    
}
