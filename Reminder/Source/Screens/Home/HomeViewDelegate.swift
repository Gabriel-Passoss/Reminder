//
//  HomeViewDelegate.swift
//  Reminder
//
//  Created by Gabriel on 14/11/25.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func logoutUser() -> Void
    func didProfileImageTapped() -> Void
    func didUpdateUsername(username: String) -> Void
}
