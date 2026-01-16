//
//  SceneDelegate.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 13/01/2026.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var appCoordinator: AppCoordinator!
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}

    
    
