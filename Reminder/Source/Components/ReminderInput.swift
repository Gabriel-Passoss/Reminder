//
//  ReminderInput.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

enum ReminderInputType {
    case text
    case time
    case select
}

class ReminderInput: UIView {
    let label: String
    let type: ReminderInputType
    var placeholder: String? = ""
    var done: (() -> Void)?
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.gray100
        label.text = self.label
        
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
    
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    init(label: String, type: ReminderInputType = .text) {
        self.label = label
        self.type = type
        
        super.init(frame: .zero)
        
        setup()
        setupConstraints()
        setupInputType()
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
    
    private func setupInputType() {
        switch self.type {
        case .text:
            break
        case .time:
            setupTimeInput()
        case .select:
            break
        }
    }
    
    private func setupTimeInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexible, doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = timePicker
    }
    
    @objc
    private func doneTapped() {
        textField.resignFirstResponder()
        done?()
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
}
