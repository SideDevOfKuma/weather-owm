//
//  Styles.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import Foundation
import SwiftUI


struct WeatherGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

extension GroupBoxStyle where Self == WeatherGroupBoxStyle {
    static var weather: WeatherGroupBoxStyle {
        .init()
    }
}
