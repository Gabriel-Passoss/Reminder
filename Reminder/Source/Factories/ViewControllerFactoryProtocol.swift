//
//  ViewControllerFactoryProtocol.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makeNewPrescriptionViewController() -> NewPrescriptionViewController
    func makeMyPrescriptionsViewController() -> MyPrescriptionsViewController
}
