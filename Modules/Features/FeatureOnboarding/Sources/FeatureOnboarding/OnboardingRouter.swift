//
//  OnboardingRouter.swift
//
//
//  Created by Oleksii Perov on 7/18/23.
//

import Foundation
import TAUIKit
import UIKit

public protocol OnboardingRouting {
    func navigateToRegistrationCodeVC()
    func showLoadingScreen()
}

public struct OnboardingRouter: OnboardingRouting {
    public let rootNavigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        rootNavigationController = navigationController
    }
    
    public func navigateToRegistrationCodeVC() {
        let viewController = RegistrationCodeViewController(theme: .default)
        viewController.router = self
        rootNavigationController.pushViewController(
            viewController,
            animated: true
        )
    }
    
    public func showLoadingScreen() {
        let vc = LoadingIndicatorViewController(theme: .default)
        vc.modalPresentationStyle = .overFullScreen
        rootNavigationController.present(vc, animated: false)
    }
}
