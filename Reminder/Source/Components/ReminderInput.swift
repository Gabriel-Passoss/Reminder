//
//  ReminderInput.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class ReminderInput: UIView {
    let inputLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.gray100
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = Colors.gray400.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.autocapitalizationType = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(label: String, placeholder: String? = nil) {
        super.init(frame: .zero)
        
        inputLabel.text = label
        textField.placeholder = placeholder
        
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(inputLabel)
        addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            inputLabel.topAnchor.constraint(equalTo: topAnchor),
            inputLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 12),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
