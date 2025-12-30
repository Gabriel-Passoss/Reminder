//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

protocol HomeFlowDelegate: AnyObject {
    func logout() -> Void
    func navigateToNewPrescription() -> Void
    func navigateToMyPrescriptions() -> Void
}
