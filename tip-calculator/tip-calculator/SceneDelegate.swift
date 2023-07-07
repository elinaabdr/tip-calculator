//
//  SceneDelegate.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 06.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TipViewController()
        window?.makeKeyAndVisible()
    }
}

