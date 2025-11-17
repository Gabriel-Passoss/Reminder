//
//  HomeButtonView.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class HomeButtonView: UIView {
    public var onTap: (() -> Void)?
    
    private let iconBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray100
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0  // Permite múltiplas linhas sem limite
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = Colors.gray400
        imageView.contentMode = .scaleAspectFit
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(icon: UIImage, title: String, description: String) {
        super.init(frame: .zero)
        backgroundColor = Colors.gray700
        layer.cornerRadius = 12
        
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
        
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconBoxView)
        addSubview(iconImageView)
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconBoxView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconBoxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconBoxView.heightAnchor.constraint(equalToConstant: 88),
            iconBoxView.widthAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconBoxView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBoxView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22.5),
            titleLabel.leadingAnchor.constraint(equalTo: iconBoxView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // Alinha no mesmo eixo Y do título
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconBoxView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22.5), // Mudança aqui: removeu lessThanOrEqualTo
            
            // Garante que a view se ajuste ao conteúdo
            bottomAnchor.constraint(greaterThanOrEqualTo: iconBoxView.bottomAnchor, constant: 12)
        ])
    }
    
    @objc
    private func handleTap() {
        onTap?()
    }
}
