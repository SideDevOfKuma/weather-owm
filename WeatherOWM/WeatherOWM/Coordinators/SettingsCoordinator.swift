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
        let viewModel = SettingsViewModel()
        viewModel.navDelegate = self
        let view = SettingsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        viewController.title = "Settings"
        presenter.setViewControllers([viewController], animated: true)
    }
}

// MARK: - SettingsNavDelegate
extension SettingsCoordinator: SettingsNavDelegate {
    func onUnitsTapped() {
        let viewModel = UnitsViewModel()
        let view = UnitsView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        viewController.title = "Units"
        presenter.pushViewController(viewController, animated: true)
    }
}
