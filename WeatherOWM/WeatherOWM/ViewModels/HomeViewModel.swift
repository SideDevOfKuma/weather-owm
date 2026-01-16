//
//  HomeViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import UIKit
import SwiftUI
import Combine

protocol HomeNavDelegate: AnyObject {
    // This will be used in the future
}

class HomeViewModel: BaseViewModel, ObservableObject {
    var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    func shoudlShowCurrentLocationWeather() -> Bool {
        return locationManager.isAuthorized()
    }
}
