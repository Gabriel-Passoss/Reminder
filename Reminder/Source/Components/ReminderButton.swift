//
//  ReminderButton.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class ReminderButton: UIView {
    var tapAction: (() -> Void)?
    
    lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        
        let button = UIButton(configuration: configuration)
        button.layer.cornerRadius = 44
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonDidTapped)))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String, icon: UIImage, backgroundColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        button.configuration?.title = title
        button.configuration?.image = icon
        button.configuration?.baseBackgroundColor = backgroundColor
        button.configuration?.baseForegroundColor = textColor
        
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc
    private func buttonDidTapped() {
        tapAction?()
    }
}
