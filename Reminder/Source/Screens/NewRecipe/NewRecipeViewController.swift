//
//  NewPrescriptionViewViewController.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import UIKit

class NewRecipeViewController: UIViewController {
    private let contentView: NewRecipeView
    
    init(view: NewRecipeView) {
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

extension NewRecipeViewController: NewRecipeViewDelegate {
    func backToHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createRecipe(_ recipe: Recipe) {
        DatabaseManager.shared.insertRecipe(recipe)
    }
}
