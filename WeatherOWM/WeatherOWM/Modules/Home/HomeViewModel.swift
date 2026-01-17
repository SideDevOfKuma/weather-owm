//
//  HomeViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import UIKit
import SwiftUI
import Combine
import CoreLocation

protocol HomeNavDelegate: AnyObject {
    // This will be used in the future
}

final class HomeViewModel: BaseViewModel, ObservableObject {
    var locationManager: LocationManager
    private let networkManager: NetworkManagerProtocol
    private var localWeatherFetchTime: Date?
    private var cityWeatherFetchTime: Date?
    private var localweatherRequested: Bool = false
    
    var localWeatherResponse: CurrentWeatherResponse? = nil
    var cityWeatherResponses: [CurrentWeatherResponse] = [] // This will store the weather for different locations.
    @Published var localWeatherFetchingStatus: WeatherFetchingStatus
    @Published var cityWeatherFetchingStatus: WeatherFetchingStatus
    
    init(
        locationManager: LocationManager,
        networkManager: NetworkManagerProtocol,
        weatherFetchingStatus: WeatherFetchingStatus = .notStarted,
        cityWeatherFetchingStatus: WeatherFetchingStatus = .notStarted
    ) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.localWeatherFetchingStatus = weatherFetchingStatus
        self.cityWeatherFetchingStatus = cityWeatherFetchingStatus
        super.init()
        locationManager.delegate = self
    }
    
    func shoudlShowCurrentLocationWeather() -> Bool {
        return locationManager.isAuthorized()
    }
}

// MARK: - Actions
extension HomeViewModel {
    func loadWeather() {
        Task {
            await getCitiesWeather()
        }
        
        if let location = locationManager.location {
            Task {
                await getLocalWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            }
        }
    }
    // Get the current location weather
    func getLocalWeather(lat: Double, lon: Double) async {
        localWeatherFetchingStatus = .fetching
        do {
            let request = try networkManager.createWeatherByGeoCodeRequest(lat: lat , lon: lon)
            let result = try await networkManager.fetchCurrentWeather(request: request)
            localWeatherResponse = result
            localWeatherFetchingStatus = WeatherFetchingStatus.success
            localWeatherFetchTime = .now
        } catch {
            DLog(error)
            DLog("Failed to fetch weather: \(error)")
            localWeatherFetchingStatus = .failed(error)
        }
    }
    
    // Get predefined locations weather
    // Get harcoded weather cities
    private func getSavedCitiesWeather() -> [String] {
        // TODO: The user defined locations should be stored either in the backend/user defaults/Swift Data/file.
        // Since we don't have a functionality for adding/removing cities we will hard code them, this is not ready for production deployment
        ["Buenos Aires", "Montevideo", "London"]
    }
    
    func getCitiesWeather() async {
        cityWeatherResponses = await getPredefinedCitiesWeather(cities: getSavedCitiesWeather())
    }
    
    func getPredefinedCitiesWeather(cities: [String]) async -> [CurrentWeatherResponse]{
        self.cityWeatherFetchingStatus = .fetching
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
            self.cityWeatherFetchingStatus = .success
            self.cityWeatherFetchTime = .now
            return groupResults
        } catch {
            DLog(error)
            DLog("Failed to fetch weather for cities")
            self.cityWeatherFetchingStatus = .failed(error)
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
}

// MARK: - LocationManagerDelegate
extension HomeViewModel: LocationManagerDelegate {
    func didUpdateAuthorizationStatus(_ status: CLAuthorizationStatus) {
        // Do Nothing
    }
    
    func didUpodateLocation(_ location: CLLocation) {
        if self.localWeatherFetchTime == nil && localweatherRequested == false {
            localweatherRequested = true
            Task {
                await getLocalWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            }
        }
    }
}
