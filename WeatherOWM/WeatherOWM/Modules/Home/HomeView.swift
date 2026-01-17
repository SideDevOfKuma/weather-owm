//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @StateObject var localWeatherCardViewModel = WeatherCardViewModel(isCurrentLocation: true)
    @StateObject var cityWeatherCardViewModel = WeatherCardViewModel(isCurrentLocation: false)
    
    @StateObject var cardViewModel = WeatherCardViewModel(isCurrentLocation: true)
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
                            self.currentWeatherView()
                        }
                        self.cityWeatherView()
                    }
                    .padding()
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
                .padding(.top, 8)
            
            switch viewModel.cityWeatherFetchingStatus {
            case .success:
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.cityWeatherResponses) { response in
                            WeatherCardView(
                                viewModel: cityWeatherCardViewModel,
                                cardStatus: .showingWeather,
                                weatherResponse: response
                            )
                        }
                    }
                }
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
    let locationManager = LocationManager()
    let networkManager = NetworkManager()
    let viewModel = HomeViewModel(locationManager: locationManager, networkManager: networkManager)
    HomeView(viewModel: viewModel)
}
