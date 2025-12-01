//
//  NewPrescriptionViewDelegate.swift
//  Reminder
//
//  Created by Gabriel on 17/11/25.
//

import Foundation

protocol NewRecipeViewDelegate: AnyObject {
    func createRecipe(_ recipe: Recipe)
    func backToHome()
}
