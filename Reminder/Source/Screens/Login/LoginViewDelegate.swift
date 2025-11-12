//
//  LoginViewDelegate.swift
//  Reminder
//
//  Created by Gabriel on 11/11/25.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func sendLoginData(email: String, password: String)
}
