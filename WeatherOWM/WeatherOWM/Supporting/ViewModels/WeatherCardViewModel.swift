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
    var isCurrentLocation: Bool
    
    init(isCurrentLocation: Bool = false) {
        self.isCurrentLocation = isCurrentLocation
    }
    
    func getWeatherIconURL(iconId: String?) -> URL? {
        if  let iconIdString = iconId,
            let iconURL = URL(string: APIConstants.openWeatherIconBaseURL + "\(iconIdString)@2x.png") {
            return iconURL
        } else {
            return nil
        }
    }
    
    func getFormattedMainTemp(_ temp: Double?) -> String {
        if let temp = temp{
            return String(format: "%.2f ºC", temp)
        } else {
            return "-- ºC"
        }
    }
    
    func getFormattedMaxTemp(_ tempMax: Double?) -> String {
        if let tempMax = tempMax {
            return String(format: "H: %.2f ºC", tempMax)
        } else {
            return "H: -- ºC"
        }
    }
    
    func getFormattedMinTemp(_ tempMin: Double?) -> String {
        if let tempMin = tempMin {
            return String(format: "L: %.2f ºC", tempMin)
        } else {
            return "L: -- ºC"
        }
    }
}

