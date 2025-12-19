//
//  NewPrescriptionViewViewController.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class NewPrescriptionViewController: UIViewController {
    private let contentView: NewPrescription
    
    init(view: NewPrescription) {
        self.contentView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(contentView)
        view.backgroundColor = Colors.gray800
        
        contentView.delegate = self
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewToBounds(contentView)
    }
}

extension NewPrescriptionViewController: NewPrescriptionViewDelegate {
    func backToHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createPrescription(_ prescription: Prescription) {
        DatabaseManager.shared.insertPrescription(prescription)
    }
}
