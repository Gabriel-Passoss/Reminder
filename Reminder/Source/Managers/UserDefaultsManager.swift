//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import UIKit

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
    
    static func updateUser(image: UIImage?, name: String?) {
        guard var currentUser = loadUser() else {
            return
        }
        
        if let imageData = image?.jpegData(compressionQuality: 1.0) {
            currentUser.image = imageData
        }
        
        if let name = name {
            currentUser.name = name
        }
        
        saveUser(currentUser)
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
}
