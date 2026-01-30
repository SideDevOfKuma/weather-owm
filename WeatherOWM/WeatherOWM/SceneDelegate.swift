//
//  SceneDelegate.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 13/01/2026.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var appCoordinator: AppCoordinator!
    var dependencyContainer: DependencyContainer!
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        dependencyContainer = DependencyContainer()
        
        // Register dependncies
        dependencyContainer.register(type: .singleInstance(NetworkManager()), for: NetworkManagerProtocol.self)
        dependencyContainer.register(type: .multipleInstance({
            LocationManager()
        }), for: LocationManager.self)
        
        appCoordinator = AppCoordinator(window: window, dependencyContainer: dependencyContainer)
        appCoordinator.start()
    }
}

    
    
