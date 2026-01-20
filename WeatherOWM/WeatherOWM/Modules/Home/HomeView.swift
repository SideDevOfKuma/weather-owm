//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI
import UIKit


struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @StateObject var localWeatherCardViewModel = WeatherCardViewModel(isCurrentLocation: true)
    @StateObject var cityWeatherCardViewModel = WeatherCardViewModel(isCurrentLocation: false)
    
    @StateObject var cardViewModel = WeatherCardViewModel(isCurrentLocation: true)
    @State var isLocAuthDelayed: Bool = false
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(Colors.primaryBlue), Color(Colors.secondaryBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    Text("Today")
                        .font(.system(size: 45, weight: .heavy, design: .default))
                        .foregroundStyle(Color(.white))
                    
                    VStack {
                        if viewModel.shoudlShowCurrentLocationWeather() {
                            self.currentWeatherView()
                        }
                        self.cityWeatherView()
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
        }
    }
    
    // Current Wheather
    @ViewBuilder func currentWeatherView() -> some View {
        Group {
            switch viewModel.localWeatherFetchingStatus {
            case .notStarted, .fetching:
                WeatherCardView(
                    viewModel: cityWeatherCardViewModel,
                    cardStatus: .shimmering
                )
            case .success:
                WeatherCardView(
                    viewModel: localWeatherCardViewModel,
                    cardStatus: .showingWeather,
                    weatherResponse: viewModel.localWeatherResponse
                )
            case .failed(let error):
                WeatherCardView(
                    viewModel: cityWeatherCardViewModel,
                    cardStatus: .showingError(error)
                )
            }
        }
    }
    
    // User Defined Weather
    @ViewBuilder func cityWeatherView() -> some View {
        Group {
            Text("Defined Locations: ")
                .font(Font.title.bold())
                .foregroundStyle(Color(.white))
                .padding(.top, 16)
            
            switch viewModel.cityWeatherFetchingStatus {
            case .success:
                List {
                    ForEach(viewModel.cityWeatherResponses) { response in
                        WeatherCardView(
                            viewModel: cityWeatherCardViewModel,
                            cardStatus: .showingWeather,
                            weatherResponse: response
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(RoundedRectangle(cornerRadius: 12).fill(Color.clear))
                }
                .listRowSpacing(20)
                .listStyle(.plain)
                .padding(.top, 8)
            case .failed(let error):
                WeatherCardView(
                    viewModel: cityWeatherCardViewModel,
                    cardStatus: .showingError(error)
                )
            case .fetching, .notStarted:
                WeatherCardView(
                    viewModel: cityWeatherCardViewModel,
                    cardStatus: .shimmering
                )
            }
        }
    }
}

#Preview {
   
    let viewModel = viewModelWithFakeWeather()
    
    HomeView(viewModel: viewModel)
}

 func viewModelWithFakeWeather() -> HomeViewModel {
     let locationManager = LocationManager()
     let networkManager = NetworkManager()
     let dummyWheater = loadDummyWeather()
     let viewModel = HomeViewModel(locationManager: locationManager, networkManager: networkManager, cityWeatherFetchingStatus: .success)
     viewModel.cityWeatherResponses = [dummyWheater, dummyWheater]
     
     return viewModel
}
