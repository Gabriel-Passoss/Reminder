//
//  ViewController+Ext.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import UIKit

extension UIViewController {
    func setupContentViewToBounds(_ contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
