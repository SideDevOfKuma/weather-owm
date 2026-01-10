//
//  LocationManager.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 10/01/2026.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private let locationManager = CLLocationManager()
    
    override init() {
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        DLog("Location update failed with error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            location = nil
        case .denied, .restricted:
            manager.stopUpdatingLocation()
            location = nil
        @unknown default:
            manager.stopUpdatingLocation()
            location = nil
        }
    }
}
