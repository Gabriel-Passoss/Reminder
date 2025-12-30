//
//  MyPrescriptionsView.swift
//  Reminder
//
//  Created by Gabriel Passos on 19/12/25.
//

import UIKit

class MyPrescriptionsView: UIView {
    weak var delegate: MyPrescriptionsViewDelegate?
    
    let headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.left")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray100
        
        button.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primaryBlueBase
        
        button.addTarget(self, action: #selector(didAddButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas receitas"
        label.font = Typography.heading
        label.textColor = Colors.primaryBlueBase
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes"
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let prescriptionsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.gray800
        
        addSubview(headerBackground)
        headerBackground.addSubview(backButton)
        headerBackground.addSubview(addButton)
        headerBackground.addSubview(titleLabel)
        headerBackground.addSubview(subtitleLabel)
        
        addSubview(contentBackground)
        contentBackground.addSubview(prescriptionsTable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackground.heightAnchor.constraint(equalToConstant: 240),
            
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 42),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            contentBackground.topAnchor.constraint(equalTo: headerBackground.bottomAnchor, constant: -Metrics.small),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            prescriptionsTable.topAnchor.constraint(equalTo: contentBackground.topAnchor),
            prescriptionsTable.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: 32),
            prescriptionsTable.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -32),
            prescriptionsTable.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor)
        ])
    }
    
    @objc
    private func didBackButtonTapped() {
        delegate?.didBackButtonTapped()
    }
    
    @objc
    private func didAddButtonTapped() {
        delegate?.didAddButtonTapped()
    }
}
