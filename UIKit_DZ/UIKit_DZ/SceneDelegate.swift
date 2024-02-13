// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        UIBarButtonItem.appearance().tintColor = UIColor.black
        window = UIWindow(windowScene: scene)
        let authVC = AuthViewController()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
}
