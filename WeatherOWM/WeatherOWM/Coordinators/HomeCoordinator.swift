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
    var networkManager: NetworkManagerProtocol
    
    init(presenter: UINavigationController, locationManager: LocationManager, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        super.init(presenter: presenter)
    }
    
    override func start() {
        showHomeScreen()
    }
}


// MARK: - Show Screens
private extension HomeCoordinator {
    func showHomeScreen() {
        let viewModel = HomeViewModel(locationManager: locationManager, networkManager: networkManager)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Home"
        viewModel.loadWeather()
        
        presenter.setViewControllers([viewController], animated: true)
    }
}
