//
//  ViewControllerFactory.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let viewController = SplashViewController(flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController {
        let viewController = LoginViewController(flowDelegate: flowDelegate)
        return viewController
    }
}
