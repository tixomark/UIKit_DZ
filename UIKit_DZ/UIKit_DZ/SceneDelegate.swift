// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Scene delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Life Cycle

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
}
