//
//  Coordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 13/01/2026.
//

import UIKit
import SwiftUI
import CoreLocation


class AppCoordinator: BaseCoordinator<UINavigationController> {
    
    let window: UIWindow
    let dependencyContainer: DependencyContainerProtocol
    
    private var requestDelayed: Bool = false
    
    init(window: UIWindow, dependencyContainer: DependencyContainerProtocol) {
        self.window = window
        
        let presenter = UINavigationController()
        presenter.isToolbarHidden = true
        
        self.dependencyContainer = dependencyContainer
    
        super.init(presenter: presenter)
        
        self.window.rootViewController = presenter
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let locationManager = dependencyContainer.resolve(LocationManager.self, as: .multipleInstance)
        
        if locationManager.authorizationStatus == .notDetermined && !requestDelayed {
            startLocationAuthorization()
        } else {
            startMain()
        }
    }
}

// MARK: - Start Flows
private extension AppCoordinator {
    func startMain() {
        let mainCoordinator = MainCoordinator(
            presenter: presenter,
            dependencyContainer: dependencyContainer
        )
        mainCoordinator.delegate = self
        mainCoordinator.start()
        store(coordinator: mainCoordinator)
    }
    
    func startLocationAuthorization() {
        let locationAuthorizationCoordinator = LocationAuthorizationCoordinator(
            presenter: presenter,
            dependencyContainer: dependencyContainer
        )
        
        locationAuthorizationCoordinator.delegate = self
        locationAuthorizationCoordinator.start()
        
        store(coordinator: locationAuthorizationCoordinator)
    }
}

// MARK: - LocalizationAuthorizationCoordinatorDelegate
extension AppCoordinator: LocationAuthorizationCoordinatorDelegate {
    func onLocationAuthorizationCoordinatorComplete(coordinator: LocationAuthorizationCoordinator) {
        self.requestDelayed = coordinator.requestDelayed
        start()
        self.delete(coordinator: coordinator)
    }
}

// MARK: - MainCoordinatorDelegate
extension AppCoordinator: MainCoordinatorDelegate {    
    func onMainCoordinatorComplete(coordinator: MainCoordinator) {
        start()
        self.delete(coordinator: coordinator)
    }
}
