//
//  LocationRequestView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import SwiftUI

struct LocationRequestView: View {
    
    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                    .padding()
                Text("We need your location to show the weather for you.")
                    .font(.system(size:28, weight: .semibold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                VStack {
                    Button {
                        GeoLocationManager.shared.requestLocationAuthorization()
                    } label: {
                        Text("Share Location")
                            .padding()
                            .font(.headline)
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(.white)
                    .clipShape(.capsule)
                    .padding()
                }
                .padding(.bottom,32)
            }
        }
    }
}

#Preview {
    LocationRequestView()
}
