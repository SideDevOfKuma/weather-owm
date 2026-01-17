//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @StateObject var currentLocationWeatherViewModel = CurrentLocationWeatherViewModel(networkManager: NetworkManager())
    @StateObject var predefinedCitiesWeatherModel = PredefinedCitiesWeatherViewModel(networkManager: NetworkManager())
    
    @State var isLocAuthDelayed: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color("SecondaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    
                    
                    Text("Today")
                        .font(.system(size: 45, weight: .heavy, design: .default))
                        .foregroundStyle(Color(.white))
                        .padding(.top, 28)
                    
                    VStack {
                        if viewModel.shoudlShowCurrentLocationWeather() {
                            CurrentLocationWeatherView(viewModel: currentLocationWeatherViewModel,
                                                       userLocation: viewModel.locationManager.location)
                        }
                        PredefinedCitiesWeatherView(viewModel: predefinedCitiesWeatherModel)
                    }
                    .padding()
                    
                }
            }
        }
    }
}

#Preview {
    let locationManager = LocationManager()
    let viewModel = HomeViewModel(locationManager: locationManager)
    HomeView(viewModel: viewModel)
}
