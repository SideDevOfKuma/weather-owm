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
    
    @State var isLocAuthDelayed: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("GradientColor1"), Color("GradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    if !locationManager.isAuthorized()
                        && isLocAuthDelayed == false
                        && locationManager.authorizationStatus != .denied {
                        LocationRequestView(locationManager: locationManager,
                                            isLocAuthDelayed:$isLocAuthDelayed)
                    } else {
                        
                        Text("Today")
                            .font(.system(size: 45, weight: .heavy, design: .default))
                            .foregroundStyle(Color(.white))
                            .padding(.top, 28)

                        VStack {
                            if locationManager.isAuthorized() && locationManager.location != nil {
                                CurrentLocationWeatherView(viewModel: currentLocationWeatherViewModel,
                                                           userLocation: $locationManager.location)
                            }
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
