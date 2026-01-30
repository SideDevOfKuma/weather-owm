//
//  LocalizationAuthorizationRequestCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI
import CoreLocation

protocol LocationAuthorizationCoordinatorDelegate: AnyObject {
    func onLocationAuthorizationCoordinatorComplete(coordinator: LocationAuthorizationCoordinator)
}

class LocationAuthorizationCoordinator: BaseCoordinator<UINavigationController> {
    weak var delegate: LocationAuthorizationCoordinatorDelegate?
    
    var locationManager: LocationManager
    var requestDelayed: Bool = false
    let dependencyContainer: DependencyContainerProtocol
    
    init(
        presenter: UINavigationController,
        dependencyContainer: DependencyContainerProtocol,
        delegate: LocationAuthorizationCoordinatorDelegate? = nil
    ) {
        self.dependencyContainer = dependencyContainer
        self.locationManager = dependencyContainer.resolve(LocationManager.self, as: .multipleInstance)
        super.init(presenter: presenter)
        
        locationManager.delegate = self
    }
    
    override func start() {
        showLocationAutrorizationRequestView()
    }
}

// MARK: - Show Screeens
private extension LocationAuthorizationCoordinator {
    func showLocationAutrorizationRequestView() {
        let viewModel = LocationAuthorizationViewModel()
        viewModel.navDelegate = self
        
        let view = LocationAuthorizationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Location Authorization"
        
        presenter.setViewControllers([viewController], animated: true)
    }
}

// MARK: - LocationAuthorizationRequestNavDelegate
extension LocationAuthorizationCoordinator: LocationAuthorizationNavDelegate {
    func onMaybeLaterTapped() {
        requestDelayed = true
        delegate?.onLocationAuthorizationCoordinatorComplete(coordinator: self)
    }
    
    func onLocalizationAuthorizationRequestTapped() {
        locationManager.requestLocationAuthorization()
    }
}

// MARK: - LocationManagerDelegate
extension LocationAuthorizationCoordinator: LocationManagerDelegate {
    func didUpodateLocation(_ location: CLLocation) {
        // Do nothing
    }
    
    func didUpdateAuthorizationStatus(_ status: CLAuthorizationStatus) {
        if status != .notDetermined {
            locationManager.delegate = nil
            delegate?.onLocationAuthorizationCoordinatorComplete(coordinator: self)
        }
    }
}
