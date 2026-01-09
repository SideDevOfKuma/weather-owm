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
    
    @StateObject var currentLocationWeatherViewModel = CurrentLocationWeatherViewModel(networkManager: NetworkManager())
    @StateObject var predefinedCitiesWeatherModel = PredefinedCitiesWeatherModel(networkManager: NetworkManager())
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("GradientColor1"), Color("GradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    if locationManager.userLocation == nil
                        && locationManager.authorizationStatus == .notDetermined {
                        LocationRequestView()
                    } else if locationManager.userLocation != nil {
                        Text("Today")
                            .font(.system(size: 45, weight: .heavy, design: .default))
                            .foregroundStyle(Color(.white))
                            .padding(.top, 28)
                        VStack {
                            CurrentLocationWeatherView(viewModel: currentLocationWeatherViewModel,
                                                       userLocation: $locationManager.userLocation)
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
    HomeView()
}
