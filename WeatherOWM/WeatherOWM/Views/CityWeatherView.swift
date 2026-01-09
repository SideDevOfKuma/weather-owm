//
//  CityWeatherView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 08/01/2026.
//

import SwiftUI

struct CityWeatherView: View {
    @State var weather: CurrentWeatherResponse
    @State var imageURL: URL?
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading  ) {
                Text(weather.name)
                    .font(Font.largeTitle.bold())
                
                HStack() {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .accessibilityLabel(weather.weather.first?.description ?? "Image describing the weather")
                        
                    } placeholder: {
                        Image(systemName: "sun.max")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                            .accessibilityLabel("Place holder image")
                            .accessibilityHint("Image of a gay sun that will be reaplced by an image describing the weather")
                    }
                    .frame(width:70, height: 70)
                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(Font.subheadline)
                    Spacer()
                    VStack (alignment: .trailing){
                        Text(weather.main.temp.toString() + " ºC")
                            .font(.system(size: 32, weight: .bold, design: .default))
                        HStack {
                            Text(String(format:"H: %.2f ºC",  weather.main.tempMax))
                                .font(.caption.italic())
                            Text(String(format:"L: %.2f ºC", weather.main.tempMin))
                                .font(.caption.italic())
                        }
                    }
                }
            }
        }
        .groupBoxStyle(.weather)
    }
}

#Preview {
    let dummyWeather = loadDummyWeather()
    CityWeatherView(weather: dummyWeather)
}
