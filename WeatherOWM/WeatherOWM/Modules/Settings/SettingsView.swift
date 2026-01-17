//
//  SettingsView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 12/01/2026.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        Form {
            Section {
                ListRow(label: "Units", value: "Metric", showChevron: true) {
                    viewModel.onUnitsTapped()
                }
            } header: {
                Text ("Temperature Units")
            } footer: {
                Text("This setting specifies the unit used to display the temperature")
            }
        }
    }
}

#Preview {
    let viewModel = SettingsViewModel()
    SettingsView(viewModel: viewModel)
}
