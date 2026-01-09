//
//  ContentView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @ObservedObject var locationManager = GeoLocationManager.shared
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("GradientColor1"), Color("GradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                Group {
                    if locationManager.userLocation == nil
                        && locationManager.authorizarionStatus == .notDetermined {
                        LocationRequestView()
                    } else if locationManager.userLocation != nil {
                        Text("Today")
                            .font(.system(size: 45, weight: .heavy, design: .default))
                            .foregroundStyle(Color(.white))
                            .padding(.top, 28)
                        VStack {
                            CurrentLocationWeatherView(userLocation: $locationManager.userLocation)
                            PredefinedCitiesWeather()
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
