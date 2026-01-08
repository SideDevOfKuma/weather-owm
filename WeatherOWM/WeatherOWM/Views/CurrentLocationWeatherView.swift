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
                            
                            AsyncImage(url: viewModel.getWeatherIconURL(iconId: viewModel.weather?.weather.first?.icon)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(.gray)
                            }
                            .frame(width:70, height: 70)
                            
                            Text(weather.weather.first?.description.capitalized ?? "")
                            Spacer()
                            VStack (alignment: .trailing){
                                Text(weather.main.temp.toString() + " ºC")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                HStack {
                                    Text(String(format:"H: %.2f ºC",  weather.main.tempMax))
                                        .font(.caption.italic())
                                    Text(String(format:"L: %.2f ºC", weather.main.tempMin))
                                        .font(.caption.italic())
                                }
                            }
                        }
                    }
                }
                .groupBoxStyle(.weather)
                
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
