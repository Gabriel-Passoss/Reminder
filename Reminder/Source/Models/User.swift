//
//  User.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

struct User: Codable {
    let email: String
    var name: String?
    var image: Data?
    let rememberMe: Bool
}
