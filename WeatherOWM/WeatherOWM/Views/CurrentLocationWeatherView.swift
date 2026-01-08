//
//  CurrentLocationWeatherView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI
import CoreLocation

struct CurrentLocationWeatherView: View {
    @StateObject var viewModel = CurrentLocationWeatherViewModel(networkManager: NetworkManager())
    
    @Binding var userLocation: CLLocation?
    
    var body: some View {
        Group {
            if viewModel.weatherFetchingStatus == WeatherFetchingStatus.success,let weather = viewModel.weather
            {
                GroupBox {
                    VStack(alignment: .leading  ) {
                        Text(weather.name)
                            .font(Font.largeTitle.bold())
                        Text("Current Location")
                                .font(Font.subheadline.italic())
                        HStack() {
                            
                            Image(systemName: "sun.max")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(.yellow)
                            Text(weather.weather.first?.description.capitalized ?? "")
                            Spacer()
                            VStack {
                                Text(weather.main.temp.toString())
                                    .font(.system(size: 40, weight: .bold, design: .default))
                            }
                        }
                    }
                }
                .padding()
            } else {
                Text("No weather available")
            }
        }
        .onAppear {
            Task { @MainActor in
                await viewModel.getLocalWeather(lat: userLocation!.coordinate.latitude,
                                                lon: userLocation!.coordinate.longitude)
            }
        }
    }
}

#Preview {
    let userLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
    CurrentLocationWeatherView(userLocation: .constant(userLocation))
}
