//
//  SceneDelegate.swift
//  TestApp
//
//  Created by Oleksii Perov on 7/18/23.
//

import UIKit
import FeatureOnboarding

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        
        let onboardingNavigationController = UINavigationController()
        let onboardingRouter = OnboardingRouter(
            navigationController: onboardingNavigationController
        )
        onboardingRouter.navigateToRegistrationCodeVC()
        
        window?.rootViewController = onboardingRouter.rootNavigationController
        window?.makeKeyAndVisible()
        window?.tintColor = .systemBlue
    }
}

