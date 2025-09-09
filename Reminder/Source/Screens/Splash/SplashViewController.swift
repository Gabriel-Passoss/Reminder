//
//  SplashViewController.swift
//  Reminder
//
//  Created by Gabriel on 22/08/25.
//

import UIKit

class SplashViewController: UIViewController {
    let contentView = SplashView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupConstraints()
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

}
