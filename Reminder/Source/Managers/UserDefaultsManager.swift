//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

class UserDefaultsManager {
    private static let userKey = "userKey"
    
    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    static func loadUser() -> User? {
        let decoder = JSONDecoder()
        
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
        }
        
        return nil
    }
}
