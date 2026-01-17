//
//  HomeCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI

class HomeCoordinator: BaseCoordinator<UINavigationController> {
    var locationManager: LocationManager
    
    init(presenter: UINavigationController, locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init(presenter: presenter)
    }
    
    override func start() {
        showHomeScreen()
    }
}


// MARK: - Show Screens
private extension HomeCoordinator {
    func showHomeScreen() {
        let viewModel = HomeViewModel(locationManager: locationManager)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Home"
        
        presenter.setViewControllers([viewController], animated: true)
    }
}
