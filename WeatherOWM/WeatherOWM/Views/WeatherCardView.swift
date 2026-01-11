//
//  WeatherCardView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 10/01/2026.
//

import SwiftUI

struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherCardViewModel
    
    var body: some View {
        Group {
            switch viewModel.cardStatus {
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
                Text(viewModel.weather?.name ?? "")
                    .font(Font.largeTitle.bold())
                
                if viewModel.isCurrentLocation == true {
                    Text("Current Location")
                            .font(Font.subheadline.italic())
                }
                
                HStack() {
                    AsyncImage(url: {
                        if let icon = viewModel.weather?.weather.first?.icon {
                            return viewModel.getWeatherIconURL(iconId: icon)
                        } else {
                            return nil
                        }
                    }()) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .accessibilityLabel(viewModel.weather?.weather.first?.description ?? "Image describing the weather")
                        
                    } placeholder: {
                        Image(systemName: "sun.max")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                            .accessibilityLabel("Place holder image")
                            .accessibilityHint("Image of a gay sun that will be reaplced by an image describing the weather")
                    }
                    .frame(width:70, height: 70)
                    
                    Text(viewModel.weather?.weather.first?.description.capitalized ?? "")
                        .font(Font.subheadline)
                    
                    Spacer()
                    
                    VStack (alignment: .trailing){
                        Text(viewModel.getFormattedMainTemp())
                            .font(.system(size: 32, weight: .bold, design: .default))
                        
                        HStack {
                            Text(viewModel.getFormattedMaxTemp())
                                .font(.caption.italic())
                            
                            Text( viewModel.getFormattedMinTemp())
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
    let viewModel = WeatherCardViewModel(networkManager: NetworkManager(), isCurrentLocation: false, cardStatus: .showingWeather)
    viewModel.weather = dummyWeather
    return WeatherCardView(viewModel: viewModel)
}

