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
                Text("Defined Locations: ")
                    .font(Font.title.bold())
                    .foregroundStyle(Color(.white))
                    .padding(.top, 8)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.currentWeatherResponses) { response in
                            CityWeatherView(weather: response, imageURL: viewModel.getWeatherIconURL(iconId: response.weather.first?.icon))
                        }
                    }
                }
                .padding(.top, 8)
                
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
