//
//  LoginViewModel.swift
//  Reminder
//
//  Created by Gabriel on 11/11/25.
//

import Foundation
import Firebase

class LoginViewModel {
    func auth(email: String, password: String, completion: (() -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
                return
            }
            
            completion?()
        }
    }
}
