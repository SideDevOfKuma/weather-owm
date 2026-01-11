//
//  WeatherCardView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 11/01/2026.
//

import Foundation
import Combine

enum WeatherCardStatus {
    case shimmering
    case showingWeather
    case showingError(Error)
}


final class WeatherCardViewModel: NSObject, ObservableObject {
    @Published var cardStatus: WeatherCardStatus
    
    private var networkManager: NetworkManager
    var weather: CurrentWeatherResponse?
    var isCurrentLocation: Bool
    
    init(networkManager: NetworkManager, isCurrentLocation: Bool = false, cardStatus: WeatherCardStatus = .shimmering) {
        self.networkManager = networkManager
        self.isCurrentLocation = isCurrentLocation
        self.cardStatus = cardStatus
        self.weather = nil
    }
    
    func getWeatherIconURL(iconId: String?) -> URL? {
        if  let iconIdString = iconId,
            let iconURL = URL(string: APIConstants.openWeatherIconBaseURL + "\(iconIdString)@2x.png") {
            return iconURL
        } else {
            return nil
        }
    }
    
    func getFormattedMainTemp() -> String {
        if let temp = weather?.main.temp{
            return String(format: "%.2f ºC", temp)
        } else {
            return "-- ºC"
        }
    }
    
    func getFormattedMaxTemp() -> String {
        if let tempMax = weather?.main.tempMax {
            return String(format: "H: %.2f ºC", tempMax)
        } else {
            return "H: -- ºC"
        }
    }
    
    func getFormattedMinTemp() -> String {
        if let tempMin = weather?.main.tempMin {
            return String(format: "L: %.2f ºC", tempMin)
        } else {
            return "L: -- ºC"
        }
    }
}

