//
//  PrescriptionTableViewCell.swift
//  Reminder
//
//  Created by Gabriel Passos on 19/12/25.
//

import UIKit

class PrescriptionTableViewCell: UITableViewCell {
    static let identifier: String = "PrescriptionTableViewCell"
    
    var handleDelete: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray200
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trashButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "trash")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray100
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = 12
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let clockIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "clock")
        icon.tintColor = Colors.gray100
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recurrenceBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = 12
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repeatIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "repeat")
        icon.tintColor = Colors.gray100
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let recurrenceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = Colors.gray700
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeBackgroundView)
        contentView.addSubview(recurrenceBackgroundView)
        contentView.addSubview(trashButton)
        
        timeBackgroundView.addSubview(clockIcon)
        timeBackgroundView.addSubview(timeLabel)
        
        recurrenceBackgroundView.addSubview(repeatIcon)
        recurrenceBackgroundView.addSubview(recurrenceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
                
                timeBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.small),
                timeBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
                timeBackgroundView.heightAnchor.constraint(equalToConstant: 28),
                
                clockIcon.leadingAnchor.constraint(equalTo: timeBackgroundView.leadingAnchor, constant: Metrics.small),
                clockIcon.centerYAnchor.constraint(equalTo: timeBackgroundView.centerYAnchor),
                clockIcon.heightAnchor.constraint(equalToConstant: 16),
                clockIcon.widthAnchor.constraint(equalToConstant: 16),
                
                timeLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: Metrics.tiny),
                timeLabel.centerYAnchor.constraint(equalTo: timeBackgroundView.centerYAnchor),
                timeLabel.trailingAnchor.constraint(equalTo: timeBackgroundView.trailingAnchor, constant: -Metrics.small),
                
                recurrenceBackgroundView.centerYAnchor.constraint(equalTo: timeBackgroundView.centerYAnchor),
                recurrenceBackgroundView.leadingAnchor.constraint(equalTo: timeBackgroundView.trailingAnchor, constant: Metrics.tiny),
                recurrenceBackgroundView.heightAnchor.constraint(equalToConstant: 28),
                
                repeatIcon.leadingAnchor.constraint(equalTo: recurrenceBackgroundView.leadingAnchor, constant: Metrics.small),
                repeatIcon.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
                repeatIcon.heightAnchor.constraint(equalToConstant: 16),
                repeatIcon.widthAnchor.constraint(equalToConstant: 16),
                
                recurrenceLabel.leadingAnchor.constraint(equalTo: repeatIcon.trailingAnchor, constant: Metrics.tiny),
                recurrenceLabel.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
                recurrenceLabel.trailingAnchor.constraint(equalTo: recurrenceBackgroundView.trailingAnchor, constant: -Metrics.small),
                
                trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
                trashButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                trashButton.heightAnchor.constraint(equalToConstant: 16),
                trashButton.widthAnchor.constraint(equalToConstant: 16),
                
                contentView.bottomAnchor.constraint(equalTo: timeBackgroundView.bottomAnchor, constant: Metrics.medium)
            ])
    }
    
    func configure(title: String, time: String, recurrence: String) {
            titleLabel.text = title
            timeLabel.text = time
            recurrenceLabel.text = recurrence
    }
    
    @objc
    private func deleteButtonTapped() {
        handleDelete?()
    }
}
