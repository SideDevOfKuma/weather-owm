//
//  CurrentLocationWeatherViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import Foundation
import CoreLocation
import Combine

final class CurrentLocationWeatherViewModel: ObservableObject {
    
    private let networkManager: NetworkManagerProtocol
    
    @Published var weatherResponse: CurrentWeatherResponse? = nil
    @Published var weatherFetchingStatus: WeatherFetchingStatus
    
    init(networkManager:NetworkManagerProtocol) {
        self.networkManager = networkManager
        weatherFetchingStatus =  WeatherFetchingStatus.notStarted
    }
    
    // Get the current location weather
    func getLocalWeather(lat: Double, lon: Double) async {
        weatherFetchingStatus = .fetching
        do {
            let request = try networkManager.createWeatherByGeoCodeRequest(lat: lat , lon: lon)
            let result = try await networkManager.fetchCurrentWeather(request: request)
            weatherResponse = result
            weatherFetchingStatus = WeatherFetchingStatus.success

        } catch {
            DLog(error)
            DLog("Failed to fetch weather: \(error)")
            weatherFetchingStatus = .failed(error)
        }
    }
}
