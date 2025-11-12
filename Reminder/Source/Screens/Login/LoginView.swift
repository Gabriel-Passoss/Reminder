//
//  LoginView.swift
//  Reminder
//
//  Created by Gabriel on 09/09/25.
//

import UIKit

class LoginView: UIView {
    public weak var delegate: LoginViewDelegate?
    
    private let loginLabel: UILabel = {
       let label = UILabel()
        label.text = "Entre para acessar suas receitas"
        label.font = Typography.subHeading
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
       let label = UILabel()
        label.text = "E-mail"
        label.font = Typography.label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email@exemplo.com"
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
    
    private let passwordLabel: UILabel = {
       let label = UILabel()
        label.text = "Senha"
        label.font = Typography.label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = Colors.gray400.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar", for: .normal)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 28
        
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.small

        addSubview(loginLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 14),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc
    private func loginButtonDidTapped() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        delegate?.sendLoginData(email: email, password: password)
    }
}
