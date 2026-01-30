//
//  MainCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI

protocol MainCoordinatorDelegate: AnyObject {
    func onMainCoordinatorComplete(coordinator: MainCoordinator)
}

enum TabBarTags: Int {
    case home
    case settings
}

class MainCoordinator: BaseCoordinator<UINavigationController> {
    weak var delegate: MainCoordinatorDelegate?
    var depedencyContainer: DependencyContainerProtocol
    
    init(
        presenter: UINavigationController ,
        dependencyContainer: DependencyContainerProtocol,
        delegate: MainCoordinatorDelegate? = nil
    ) {
        self.depedencyContainer = dependencyContainer
        self.delegate = delegate
        super.init(presenter: presenter)
    }
    
    override func start() {
        presenter.setNavigationBarHidden(true, animated: false)
        showRoot()
    }
}

// MARK: - Show Screens
private extension MainCoordinator {
    func showRoot() {
        let homeCoordinator = configureHomeCoordinator()
        let settingsCoordinator = configureSettingsCoordiantor()
        
        let controllers = [
            homeCoordinator.presenter,
            settingsCoordinator.presenter
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        
        presenter.setViewControllers([tabBarController], animated: true)
    }
}

// MARK: - Sub Coordinators
private extension MainCoordinator {
    func configureHomeCoordinator() -> HomeCoordinator {
        let flowPresenter = UINavigationController()
        flowPresenter.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: TabBarTags.home.rawValue
        )
        
        let coordinator = HomeCoordinator(presenter: flowPresenter, dependencyContainer: depedencyContainer)
        coordinator.start()
        
        store(coordinator: coordinator)
        
        return coordinator
    }
    
    func configureSettingsCoordiantor() -> SettingsCoordinator {
        let flowPresenter = UINavigationController()
        flowPresenter.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: TabBarTags.settings.rawValue
        )
        
        let coordinator = SettingsCoordinator(presenter: flowPresenter)
        coordinator.start()
        
        store(coordinator: coordinator)
        
        return coordinator
    }
}

