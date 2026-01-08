//
//  WeatherDataMock.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import Foundation


func loadDummyWeather() -> CurrentWeatherResponse {
    let data: Data
    guard let file = Bundle.main.url(forResource: "DummyWeatherData", withExtension: "json") else {
        fatalError("Couldn't find DummyWeatherData.json in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load DummyWeatherData.json from main bundle:\n\(error)")
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    do {
        let decoded = try decoder.decode(CurrentWeatherResponse.self, from: data)
        return decoded
    } catch {
        fatalError("Couldn't parse DummyWeatherData.json:\n \(error)")
    }
}
