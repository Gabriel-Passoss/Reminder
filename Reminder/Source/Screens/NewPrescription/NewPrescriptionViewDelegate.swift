//
//  NewPrescriptionViewDelegate.swift
//  Reminder
//
//  Created by Gabriel on 17/11/25.
//

import Foundation

protocol NewPrescriptionViewDelegate: AnyObject {
    func createPrescription(_ prescription: Prescription)
    func backToHome()
}
