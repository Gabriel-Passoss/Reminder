//
//  ReminderCheckBox.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class ReminderCheckBox: UIView {
    var isChecked: Bool = false {
        didSet {
            updateCheckboxAppearance()
        }
    }
    
    private let checkBox: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square")
        config.baseForegroundColor = Colors.gray400
        config.contentInsets = .zero
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.gray200
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(title: String) {
        super.init(frame: .zero)
        label.text = title
        
        setup()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(checkBox)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupActions() {
        checkBox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
    }
    
    private func updateCheckboxAppearance() {
        var config = checkBox.configuration
        config?.image = UIImage(systemName: isChecked ? "checkmark.square.fill" : "square")
        config?.baseForegroundColor = isChecked ? Colors.primaryRedBase : Colors.gray400
        checkBox.configuration = config
    }
}

