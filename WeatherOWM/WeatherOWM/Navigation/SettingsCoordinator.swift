//
//  SettingsCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI

class SettingsCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showSettings()
    }
}

// MARK: - Show Screens
private extension SettingsCoordinator {
    func showSettings() {
        let view = SettingsView()
        let viewController = UIHostingController(rootView: view)
        
        viewController.title = "Settings"
        presenter.setViewControllers([viewController], animated: true)
    }
}

