//
//  Rain.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

struct Rain: Codable{
    let oneHour: Double // Original API key
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
