//
//  LoadingView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 09/01/2026.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        GroupBox {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.gradientColor1))
                .accessibilityLabel("An action is in progress")
        }
        .groupBoxStyle(.weather)
    }
}
