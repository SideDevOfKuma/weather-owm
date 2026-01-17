//
//  PredefinedCitiesWeather.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI

struct PredefinedCitiesWeatherView: View {
    @ObservedObject var viewModel: PredefinedCitiesWeatherViewModel
    @StateObject var weatherCardViewModel = WeatherCardViewModel(isCurrentLocation: false)
    
    var body: some View {
        Group {
            Text("Defined Locations: ")
                .font(Font.title.bold())
                .foregroundStyle(Color(.white))
                .padding(.top, 8)
            
            switch viewModel.weatherFetchingStatus {
            case .success:
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.currentWeatherResponses) { response in
                            WeatherCardView(viewModel: weatherCardViewModel,
                                            cardStatus: .showingWeather,
                                            weatherResponse: response)
                        }
                    }
                }
                .padding(.top, 8)
            case .failed(let error):
                WeatherCardView(viewModel: weatherCardViewModel, cardStatus: .showingError(error))
            case .fetching, .notStarted:
                WeatherCardView(viewModel: weatherCardViewModel, cardStatus: .shimmering)
            }
        }
        .onAppear() {
            Task { @MainActor in
                await viewModel.getCitiesWeather()
            }
        }
    }
}

#Preview {
    let viewModel = PredefinedCitiesWeatherViewModel(networkManager: NetworkManager())
    PredefinedCitiesWeatherView(viewModel: viewModel)
}
