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
                            
                            AsyncImage(url: {
                                if let icon = viewModel.weather?.weather.first?.icon {
                                    return viewModel.getWeatherIconURL(iconId: icon)
                                } else {
                                    return nil
                                }
                            }()) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(.gray)
                            }
                            .frame(width:70, height: 70)
                            
                            Text(weather.weather.first?.description.capitalized ?? "")
                                .font(Font.subheadline)
                            Spacer()
                            VStack (alignment: .trailing){
                                Text({
                                    let temp = weather.main.temp
                                    if temp.isFinite {
                                        return String(format: "%.2f ºC", temp)
                                    } else {
                                        return "-- ºC"
                                    }
                                }())
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                HStack {
                                    Text(weather.main.tempMax.isFinite ? String(format: "H: %.2f ºC", weather.main.tempMax) : "H: -- ºC")
                                        .font(.caption.italic())
                                    Text(weather.main.tempMin.isFinite ? String(format: "L: %.2f ºC", weather.main.tempMin) : "L: -- ºC")
                                        .font(.caption.italic())
                                }
                            }
                        }
                    }
                }
                .groupBoxStyle(.weather)
            } else {
                LoadingView()
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
