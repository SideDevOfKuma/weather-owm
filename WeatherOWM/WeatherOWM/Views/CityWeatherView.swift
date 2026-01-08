//
//  CityWeatherView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI

struct CityWeatherView: View {
    @State var weather: CurrentWeatherResponse
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading  ) {
                Text(weather.name)
                    .font(Font.largeTitle.bold())
                
                HStack() {
                    
                    Image(systemName: "sun.max")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.yellow)
                    Text(weather.weather.first?.description.capitalized ?? "")
                    Spacer()
                    VStack {
                        Text(weather.main.temp.toString())
                            .font(.system(size: 40, weight: .bold, design: .default))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    let dummyWeather = loadDummyWeather()
    CityWeatherView(weather: dummyWeather)
}
