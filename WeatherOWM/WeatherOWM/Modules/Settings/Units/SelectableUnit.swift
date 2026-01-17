//
//  SelectableUnit.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 17/01/2026.
//

import Foundation

enum TempUnit: String {
    case metric = "metric"
    case imperial = "imperial"
    case standard = "standard"
}

struct SelectableUnit: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var type: TempUnit = .standard
    var isSelected: Bool = false
}
