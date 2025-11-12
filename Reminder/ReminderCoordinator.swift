//
//  ReminderCoordinator.swift
//  Reminder
//
//  Created by Gabriel on 11/11/25.
//

import Foundation
import UIKit

class ReminderCoordinator {
    private var navigation: UINavigationController?
    private var viewControllerFactory = ViewControllerFactory()
    
    func start() -> UINavigationController? {
        let viewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}

extension ReminderCoordinator: SplashFlowDelegate {
    func showLoginBottomSheet() {
        let viewController = viewControllerFactory.makeLoginViewController(flowDelegate: self)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.navigation?.present(viewController, animated: false) {
            viewController.animateShowLogin()
        }
    }
}

extension ReminderCoordinator: LoginFlowDelegate {
    func navigateToHome() {
        self.navigation?.dismiss(animated: true)
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        
        self.navigation?.pushViewController(viewController, animated: true)
    }
}
