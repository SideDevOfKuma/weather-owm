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
            return String(format: "%.2f", temp)
        } else {
            return "--"
        }
    }
    
    func getFormattedMaxTemp(_ tempMax: Double?) -> String {
        if let tempMax = tempMax {
            return String(format: "H: %.2f", tempMax)
        } else {
            return "H: --"
        }
    }
    
    func getFormattedMinTemp(_ tempMin: Double?) -> String {
        if let tempMin = tempMin {
            return String(format: "L: %.2f", tempMin)
        } else {
            return "L: --"
        }
    }
}

