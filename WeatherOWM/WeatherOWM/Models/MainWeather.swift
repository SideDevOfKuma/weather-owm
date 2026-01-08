//
//  MainWeather.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

struct MainWeather: Codable {
    let temp: Double
    let feelsLike: Double // API key: feels_like
    let tempMin: Double // API key: temp_min
    let tempMax: Double // API key: temp_max
    let pressure: Int
    let humidity: Int
    let seaLevel: Int // API key: sea_level
    let grndLevel: Int  // API key: grnd_level
}
