//
//  ViewControllerFactory.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let splashView = SplashView()
        let viewController = SplashViewController(view: splashView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController {
        let loginView = LoginView()
        let viewController = LoginViewController(view: loginView, flowDelegate: flowDelegate)
        return viewController
    }
}
