//
//  WeatherCardView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 10/01/2026.
//

import SwiftUI

struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherCardViewModel
    @State var cardStatus: WeatherCardStatus
    @State var weatherResponse: CurrentWeatherResponse?
    
    var body: some View {
        Group {
            switch cardStatus {
            case .shimmering:
                shimmeringCardView()
            case .showingWeather:
                weatherCardView()
            case .showingError(let error):
                errorCardView(error)
            }
        }
    }
}

extension WeatherCardView {
    @ViewBuilder func shimmeringCardView() -> some View {
        GeometryReader { geometry in
            GroupBox {
                VStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: geometry.size.width * 0.85,
                               height: 38)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: geometry.size.width * 0.55,
                               height: 20)
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width:70, height: 70)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: geometry.size.width * 0.3, height: 14)
                        Spacer()
                        VStack(alignment: .trailing) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: geometry.size.width * 0.3, height: 38)
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: geometry.size.width * 0.15,
                                           height: 12)
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: geometry.size.width * 0.15,
                                           height: 12)
                            }
                        }
                    }
                }.shimmer(speed: 0.8 ,angle: 45)
            }
            .frame(width: geometry.size.width)
            .groupBoxStyle(.weather)
        }
    }
    
    @ViewBuilder func errorCardView(_ error: Error) -> some View {
        GroupBox {
            VStack {
                Label {
                    Text("No Weather Data")
                        .font(.title)
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title)
                        .foregroundColor(.orange)
                }
                let errorStr = error.localizedDescription
                Text(errorStr)
                    .font(.body)
                    .padding()
            }
        }
    }
    
    @ViewBuilder func weatherCardView() -> some View {
        GroupBox {
            VStack(alignment: .leading  ) {
                Text(weatherResponse?.name ?? "")
                    .font(Font.largeTitle.bold())
                
                if viewModel.isCurrentLocation == true {
                    Text("Current Location")
                            .font(Font.subheadline.italic())
                }
                
                HStack() {
                    AsyncImage(url: {
                        if let icon = weatherResponse?.weather.first?.icon {
                            return viewModel.getWeatherIconURL(iconId: icon)
                        } else {
                            return nil
                        }
                    }()) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .accessibilityLabel(weatherResponse?.weather.first?.description ?? "Image describing the weather")
                        
                    } placeholder: {
                        Image(systemName: "sun.max")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                            .accessibilityLabel("Place holder image")
                            .accessibilityHint("Image of a gay sun that will be reaplced by an image describing the weather")
                    }
                    .frame(width:70, height: 70)
                    
                    Text(weatherResponse?.weather.first?.description.capitalized ?? "")
                        .font(Font.subheadline)
                    
                    Spacer()
                    
                    VStack (alignment: .trailing){
                        Text(viewModel.getFormattedMainTemp(weatherResponse?.main.temp))
                            .font(.system(size: 32, weight: .bold, design: .default))
                        
                        HStack {
                            Text(viewModel.getFormattedMaxTemp(weatherResponse?.main.tempMax))
                                .font(.caption.italic())
                            
                            Text( viewModel.getFormattedMinTemp(weatherResponse?.main.tempMin))
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
    let viewModel = WeatherCardViewModel(isCurrentLocation: false)

    WeatherCardView(viewModel: viewModel, cardStatus: .shimmering, weatherResponse: dummyWeather)
}

