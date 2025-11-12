//
//  LoginViewModel.swift
//  Reminder
//
//  Created by Gabriel on 11/11/25.
//

import Foundation
import Firebase

enum LoginError: Error {
    case authenticationFailed(String)
    
    var localizedDescription: String {
        switch self {
        case .authenticationFailed(let message):
            return message
        }
    }
}

class LoginViewModel {
    func auth(email: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                completion(.failure(.authenticationFailed("Verifique suas credenciais e tente novamente!")))
                return
            }
            
            completion(.success(()))
        }
    }
}
