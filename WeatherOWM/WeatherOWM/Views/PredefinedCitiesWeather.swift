//
//  PredefinedCitiesWeather.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI

struct PredefinedCitiesWeather: View {
    @StateObject var viewModel: PredefinedCitiesWeatherModel = PredefinedCitiesWeatherModel(networkManager: NetworkManager())
    
    var body: some View {
        Group {
            if viewModel.weatherFetchingStatus == .success {
                List(viewModel.currentWeatherResponses) { response in
                    CityWeatherView(weather: response)
                }
            } else {
                Text("No Data Found")
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
    PredefinedCitiesWeather()
}
