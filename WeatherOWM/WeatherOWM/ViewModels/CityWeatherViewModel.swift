//
//  CityWeatherViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import Foundation
import CoreLocation
import Combine

final class CityWeatherModel: ObservableObject {
    
    private var networkManager: NetworkManager
    
    @Published var currentWeatherResponses: [CurrentWeatherResponse] = [] // This will store the weather for different locations.
    @Published var weatherFetchingStatus: WeatherFetchingStatus
    
    // TODO: The user defined locations should be stored either in the backend or user defaults.
    var userDefinedLocations: [String] = ["Buenos Aires", "Montevideo", "London"]
    
    init(networkManager: NetworkManager) {
        self.weatherFetchingStatus = .notStarted
        self.networkManager = networkManager
    }
    
    // Get predefined locations weather
    
    func getWeather(cities: [String]) async {
        // TODO: Use task group to fecth weather for all cities.
    }
}
