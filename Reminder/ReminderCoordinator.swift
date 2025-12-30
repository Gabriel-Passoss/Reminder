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
        
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        self.navigation?.pushViewController(viewController, animated: true)
    }
}
extension ReminderCoordinator: HomeFlowDelegate {
    func logout() {
        self.navigation?.popViewController(animated: true)
        self.showLoginBottomSheet()
    }
    
    func navigateToNewPrescription() {
        let viewController = viewControllerFactory.makeNewPrescriptionViewController()
        self.navigation?.pushViewController(viewController, animated: true)
    }
    
    func navigateToMyPrescriptions() {
        let viewController = viewControllerFactory.makeMyPrescriptionsViewController()
        self.navigation?.pushViewController(viewController, animated: true)
    }
}
