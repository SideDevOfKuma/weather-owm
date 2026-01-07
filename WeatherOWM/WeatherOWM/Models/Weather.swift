//
//  Weather.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

struct Weather: Codable {
    let id: Int 
    let main: String
    let description: String
    let icon: String
}
