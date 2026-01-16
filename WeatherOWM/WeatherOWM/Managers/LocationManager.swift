//
//  LocationManager.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 10/01/2026.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateAuthorizationStatus (_ status: CLAuthorizationStatus)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var location: CLLocation?
    var authorizationStatus: CLAuthorizationStatus
    
    let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func isAuthorized() -> Bool {
        [.authorizedAlways, .authorizedWhenInUse].contains(authorizationStatus)
    }
}


// MARK: - CLLocationManagerDelegate
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
        
        delegate?.didUpdateAuthorizationStatus(authorizationStatus)
    }
}
