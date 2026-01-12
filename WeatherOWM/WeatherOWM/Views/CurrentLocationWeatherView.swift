//
//  CurrentLocationWeatherView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI
import CoreLocation

struct CurrentLocationWeatherView: View {
    @ObservedObject var viewModel: CurrentLocationWeatherViewModel
    
    @Binding var userLocation: CLLocation?
    
    @StateObject var weatherCardViewModel = WeatherCardViewModel(isCurrentLocation: true)
    
    var body: some View {
        Group {
            switch viewModel.weatherFetchingStatus {
            case .notStarted, .fetching:
                WeatherCardView(viewModel: weatherCardViewModel, cardStatus: .shimmering)
            case .success:
                WeatherCardView(viewModel: weatherCardViewModel, cardStatus: .showingWeather, weatherResponse: viewModel.weatherResponse)
            case .failed(let error):
                WeatherCardView(viewModel: weatherCardViewModel, cardStatus: .showingError(error))
            }
        }
        .onAppear {
            guard let location = userLocation else { return }
            Task { @MainActor in
                await viewModel.getLocalWeather(lat: location.coordinate.latitude,
                                                lon: location.coordinate.longitude)
            }
        }
    }
}

#Preview {
    let userLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
    let viewModel = CurrentLocationWeatherViewModel(networkManager: NetworkManager())
    CurrentLocationWeatherView(viewModel: viewModel, userLocation: .constant(userLocation))
}
