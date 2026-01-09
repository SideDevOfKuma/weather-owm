//
//  PredefinedCitiesWeatherModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import Foundation
import CoreLocation
import Combine

// TODO: Duplicated code, refactor.
final class PredefinedCitiesWeatherModel: ObservableObject {
    
    private var networkManager: NetworkManagerProtocol
    
    @Published var currentWeatherResponses: [CurrentWeatherResponse] = [] // This will store the weather for different locations.
    @Published var weatherFetchingStatus: WeatherFetchingStatus
    
    init(networkManager: NetworkManagerProtocol) {
        self.weatherFetchingStatus = .notStarted
        self.networkManager = networkManager
    }
    // Get harcoded weather cities
    private func getSavedCitiesWeather() -> [String] {
        // TODO: The user defined locations should be stored either in the backend/user defaults/Swift Data/file.
        // Since we don't have a functionality for adding/removing cities we will hard code them, this is not ready for production deployment
        ["Buenos Aires", "Montevideo", "London"]
    }
    
    func getCitiesWeather() async {
        currentWeatherResponses = await getPredefinedCitiesWeather(cities: getSavedCitiesWeather())
    }
    
    // Get predefined locations weather
    func getPredefinedCitiesWeather(cities: [String]) async -> [CurrentWeatherResponse]{
        self.weatherFetchingStatus = .fetching
        var results: [CurrentWeatherResponse] = []
        do {
            let groupResults = try await withThrowingTaskGroup(of: CurrentWeatherResponse.self) { group in
                for city in cities {
                    group.addTask {
                        try await self.getCityWeather(city: city)
                    }
                }
                
                for try await response in group {
                    results.append(response)
                }
                return results
            }
            self.weatherFetchingStatus = .success
            return groupResults
        } catch {
            DLog(error)
            DLog("Failed to fetch weather for cities")
            self.weatherFetchingStatus = .failed
            return results
        }
    }
    
    func getCityWeather(city: String) async throws -> CurrentWeatherResponse {
        do{
            let request = try self.networkManager.createWeatherByCityRequest(city: city)
            return try await self.networkManager.fetchCurrentWeather(request: request)
            
        } catch {
            throw NetworkError.invalidResponse
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
