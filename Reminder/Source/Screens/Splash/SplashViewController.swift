//
//  SplashViewController.swift
//  Reminder
//
//  Created by Gabriel on 22/08/25.
//

import UIKit

class SplashViewController: UIViewController {
    let contentView = SplashView()
    weak var flowDelegate: SplashFlowDelegate?
    
    init(flowDelegate: SplashFlowDelegate) {
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupConstraints()
        setupGesture()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc
    private func showLoginBottomSheet() {
        self.flowDelegate?.showLoginBottomSheet()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        self.view.addGestureRecognizer(tapGesture)
    }
}
