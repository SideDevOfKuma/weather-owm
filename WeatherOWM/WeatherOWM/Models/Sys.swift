//
//  Sys.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
