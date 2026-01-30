//
//  HomeCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI

class HomeCoordinator: BaseCoordinator<UINavigationController> {
    var dependencyContainer: DependencyContainerProtocol
    
    init(presenter: UINavigationController, dependencyContainer: DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
        super.init(presenter: presenter)
    }
    
    override func start() {
        showHomeScreen()
    }
}


// MARK: - Show Screens
private extension HomeCoordinator {
    func showHomeScreen() {
        let viewModel = HomeViewModel(dependencyContainer: dependencyContainer)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = ""
        viewModel.loadWeather()
        
        presenter.setViewControllers([viewController], animated: true)
    }
}
