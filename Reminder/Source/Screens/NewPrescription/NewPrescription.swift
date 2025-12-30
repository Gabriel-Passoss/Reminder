//
//  NewPrescriptionView.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class NewPrescription: UIView {
    weak var delegate: NewPrescriptionViewDelegate?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.gray100
        
        button.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nova receita"
        label.font = Typography.heading
        label.textColor = Colors.primaryRedBase
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Adicione a sua prescrição médica para receber lembretes de quando tomar seu medicamento"
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let medicationNameTextField: ReminderInput = {
        let textField = ReminderInput(label: "Remédio")
        textField.placeholder = "Nome do remédio"
        
        return textField
    }()
    
    let medicationScheduleTextField: ReminderInput = {
        let textField = ReminderInput(label: "Horário", type: .time)
        textField.placeholder = "00:00"
        
        return textField
    }()
    
    let recurrenceTextField: ReminderInput = {
        let textField = ReminderInput(label: "Recorrência", type: .select)
        textField.selectPickerOptions = [
            "De hora em hora",
            "2 em 2 horas",
            "4 em 4 horas",
            "6 em 6 horas",
            "8 em 8 horas",
            "12 em 12 horas",
            "Um por dia"
        ]
        
        textField.placeholder = "Selecione"
        
        return textField
    }()
    
    let takeNowCheckbox: ReminderCheckBox = {
        let checkbox = ReminderCheckBox(title: "Tomar agora")
        
        return checkbox
    }()
    
    lazy var saveButton: ReminderButton = {
        let button = ReminderButton(
            title: "Adicionar",
            icon: UIImage(systemName: "plus")!,
            backgroundColor: Colors.primaryRedBase,
            textColor: Colors.gray800
        )
        
        button.tapAction = didNewPrescriptionButtonTapped
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
        setupInputObservers()
        validateInputs() // Valida inicialmente (botão começa desabilitado)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(medicationNameTextField)
        addSubview(medicationScheduleTextField)
        addSubview(recurrenceTextField)
        addSubview(takeNowCheckbox)
        addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            medicationNameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            medicationNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            medicationNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            medicationScheduleTextField.topAnchor.constraint(equalTo: medicationNameTextField.bottomAnchor, constant: 20),
            medicationScheduleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            medicationScheduleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            recurrenceTextField.topAnchor.constraint(equalTo: medicationScheduleTextField.bottomAnchor, constant: 20),
            recurrenceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            recurrenceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            takeNowCheckbox.topAnchor.constraint(equalTo: recurrenceTextField.bottomAnchor, constant: 20),
            takeNowCheckbox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    private func setupInputObservers() {
        medicationNameTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        medicationScheduleTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        recurrenceTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChange() {
        validateInputs()
    }
    
    private func validateInputs() {
        let isMedicationNameFilled = !medicationNameTextField.getText().isEmpty
        let isMedicationScheduleFilled = !medicationScheduleTextField.getText().isEmpty
        let isRecurrenceFilled = !recurrenceTextField.getText().isEmpty
        
        let allFieldsFilled = isMedicationNameFilled && isMedicationScheduleFilled && isRecurrenceFilled
        
        saveButton.button.isEnabled = allFieldsFilled
        saveButton.button.backgroundColor = allFieldsFilled ? Colors.primaryRedBase : Colors.gray700
    }
    
    @objc
    private func didBackButtonTapped() {
        delegate?.backToHome()
    }
    
    @objc
    private func didNewPrescriptionButtonTapped() {
        let prescription = Prescription(
            id: Int.random(in: 1...100000),
            remedy: medicationNameTextField.getText(),
            time: medicationScheduleTextField.getText(),
            recurrence: recurrenceTextField.getText(),
            takeNow: false
        )
        
        delegate?.createPrescription(prescription)
        clearInputs()
    }
    
    private func clearInputs() {
        medicationNameTextField.textField.text = ""
        medicationScheduleTextField.textField.text = ""
        recurrenceTextField.textField.text = ""
        takeNowCheckbox.isChecked = false
        validateInputs()
    }
}
