//
//  HomeView.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import UIKit

class HomeView: UIView {
    public weak var delegate: HomeViewDelegate?
    
    private let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Colors.gray800
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setupProfileImageGesture)))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoutButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        imageView.clipsToBounds = true
        imageView.tintColor = Colors.primaryRedBase
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setupLogoutButton)))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Boas vindas"
        label.textColor = Colors.gray200
        label.font = Typography.label.withSize(16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = Typography.heading
        textField.textColor = Colors.gray100
        textField.placeholder = "Insira seu nome"
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(setupUsernameTextField), for: .editingDidEnd)
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let myPrescriptionsButton: HomeButtonView = {
        let button = HomeButtonView(
            icon: UIImage(named: "paper-icon")!,
            title: "Minhas receitas",
            description: "Acompanhe os medicamentos e gerencie lembretes"
        )
        
        return button
    }()
    
    let newPrescriptionButton: HomeButtonView = {
        let button = HomeButtonView(
            icon: UIImage(named: "pills-icon")!,
            title: "Nova receita",
            description: "Cadastre novos lembretes de receitas"
        )
        
        return button
    }()
    
    private let feedbackButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Avaliar"
        configuration.baseForegroundColor = Colors.gray800
        configuration.baseBackgroundColor = Colors.gray100
        configuration.image = UIImage(systemName: "star")
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        
        let button = UIButton(configuration: configuration)
        button.layer.cornerRadius = 28
        
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
        self.backgroundColor = Colors.gray600
        
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(logoutButton)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(usernameTextField)
        
        addSubview(contentBackground)
        contentBackground.addSubview(myPrescriptionsButton)
        contentBackground.addSubview(newPrescriptionButton)
        contentBackground.addSubview(feedbackButton)
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                profileBackground.topAnchor.constraint(equalTo: topAnchor),
                profileBackground.heightAnchor.constraint(equalToConstant: 240),
                profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
                profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                profileImage.topAnchor.constraint(equalTo: profileBackground.safeAreaLayoutGuide.topAnchor, constant: 22),
                profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
                profileImage.heightAnchor.constraint(equalToConstant: 64),
                profileImage.widthAnchor.constraint(equalToConstant: 64),
                
                logoutButton.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 20),
                logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
                logoutButton.heightAnchor.constraint(equalToConstant: 24),
                
                welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.small),
                welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
                
                usernameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.tiny),
                usernameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
                
                myPrescriptionsButton.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: 40),
                myPrescriptionsButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: 32),
                myPrescriptionsButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -32),
                
                newPrescriptionButton.topAnchor.constraint(equalTo: myPrescriptionsButton.bottomAnchor, constant: 16),
                newPrescriptionButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: 32),
                newPrescriptionButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -32),
                
                feedbackButton.heightAnchor.constraint(equalToConstant: 56),
                feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.medium),
                feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
                feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
                
                contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
                contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    @objc
    private func setupProfileImageGesture() {
        self.delegate?.didProfileImageTapped()
    }
    
    @objc
    private func setupLogoutButton() {
        self.delegate?.logoutUser()
    }
    
    @objc
    private func setupUsernameTextField() {
        self.delegate?.didUpdateUsername(username: usernameTextField.text ?? "")
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
