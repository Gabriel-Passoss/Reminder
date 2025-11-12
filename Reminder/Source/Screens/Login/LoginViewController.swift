//
//  LoginViewController.swift
//  Reminder
//
//  Created by Gabriel on 09/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    let contentView: LoginView
    let viewModel = LoginViewModel()
    weak var flowDelegate: LoginFlowDelegate?
    
    init(view: LoginView, flowDelegate: LoginFlowDelegate) {
        self.contentView = view
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        setup()
        setupConstraints()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45),
        ])
    }
    
    func animateShowLogin(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: CGFloat(contentView.frame.height))
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
                completion?()
        }
    }
    
    private func presentRememberMeAlert(email: String) {
        let alert = UIAlertController(title: "Salvar acesso", message: "Deseja salvar seu acesso para futuras sessões?", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
            let user = User(email: email, rememberMe: true)
            UserDefaultsManager.saveUser(user)
            self.flowDelegate?.navigateToHome()
        }
        
        let cancelAction = UIAlertAction(title: "Não salvar", style: .cancel) { _ in
            self.flowDelegate?.navigateToHome()
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

extension LoginViewController: LoginViewDelegate {
    func sendLoginData(email: String, password: String) {
        viewModel.auth(email: email, password: password) { [weak self] in
            self?.presentRememberMeAlert(email: email)
        }
    }
}
