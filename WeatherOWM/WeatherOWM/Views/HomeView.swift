//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @ObservedObject var locationManager: LocationManager
    
    @StateObject var currentLocationWeatherViewModel = CurrentLocationWeatherViewModel(networkManager: NetworkManager())
    @StateObject var predefinedCitiesWeatherModel = PredefinedCitiesWeatherModel(networkManager: NetworkManager())
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("GradientColor1"), Color("GradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    if locationManager.location == nil && locationManager.authorizationStatus == .notDetermined {
                        LocationRequestView(locationManager: locationManager)
                    } else if locationManager.location != nil {
                        Text("Today")
                            .font(.system(size: 45, weight: .heavy, design: .default))
                            .foregroundStyle(Color(.white))
                            .padding(.top, 28)
                        VStack {
                            CurrentLocationWeatherView(viewModel: currentLocationWeatherViewModel,
                                                       userLocation: $locationManager.location)
                            PredefinedCitiesWeather(viewModel: predefinedCitiesWeatherModel)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    let locationManager = LocationManager()
    HomeView(locationManager: locationManager)
}
