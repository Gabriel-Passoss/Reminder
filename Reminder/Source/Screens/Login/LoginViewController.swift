//
//  LoginViewController.swift
//  Reminder
//
//  Created by Gabriel on 09/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let viewModel = LoginViewModel()
    weak var flowDelegate: LoginFlowDelegate?
    
    init(flowDelegate: LoginFlowDelegate) {
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        setup()
        setupConstraints()
        setupGesture()
    }
    
    private func setup() {
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45),
        ])
    }
    
    private func setupGesture() {
        
    }
    
    func animateShowLogin(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        loginView.transform = CGAffineTransform(translationX: 0, y: CGFloat(loginView.frame.height))
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
                completion?()
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func sendLoginData(email: String, password: String) {
        viewModel.auth(email: email, password: password) {
            self.flowDelegate?.navigateToHome()
        }
    }
}
