//
//  CurrentWeatherResponse.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

struct CurrentWeatherResponse: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String // API internal parameter
    let main: MainWeather
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int // City ID, this has been deprecated
    let name: String // City name, this has been deprecated
    let cod: Int
}
