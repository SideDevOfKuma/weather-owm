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
    
    @Published var weather: CurrentWeatherResponse? = nil
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
            weather = result
            weatherFetchingStatus = WeatherFetchingStatus.success

        } catch {
            DLog(error)
            DLog("Failed to fetch weather: \(error)")
            weatherFetchingStatus = WeatherFetchingStatus.failed
        }
    }
    
    func getWeatherIconURL(iconId: String?) -> URL? {
        if  let iconIdString = iconId,
            let iconURL = URL(string: APIConstants.openWeatherIconBaseURL + "\(iconIdString)@2x.png") {
            return iconURL
        } else {
            return nil
        }
    }
}
