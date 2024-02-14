// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Scene delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = ShoeStoreTabBarController()
        window?.makeKeyAndVisible()
    }
}
