//
//  WeatherOWMApp.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI

@main
struct WeatherOWMApp: App {
    var body: some Scene {
        WindowGroup {
            let locationManager = LocationManager()
            HomeView(locationManager: locationManager)
        }
    }
}
