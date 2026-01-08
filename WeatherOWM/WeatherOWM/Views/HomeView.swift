//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @ObservedObject var locationManager = GeoLocationManager.shared
    
    var body: some View {
        Group {
            if locationManager.userLocation == nil
                && locationManager.authorizarionStatus == .notDetermined {
                LocationRequestView()
            } else if locationManager.userLocation != nil {
                VStack {
                    CurrentLocationWeatherView(userLocation: $locationManager.userLocation)
                    Text("User Location: \(String(describing: locationManager.userLocation))")
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
