//
//  UnitsView.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import SwiftUI

struct UnitsView: View {
    @ObservedObject var viewModel: UnitsViewModel
    @AppStorage("TempUnit") var selectedUnit: TempUnit = .metric
    
    init(viewModel: UnitsViewModel, selectedUnit: TempUnit = TempUnit.standard) {
        self.viewModel = viewModel
        self.selectedUnit = selectedUnit
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        List() {
            Section {
                ForEach(viewModel.unitOptions) { option in
                    SelectableListRow(title: option.title, isSelected: option.type == self.selectedUnit) {
                        selectedUnit = option.type
                    }
                }
            } header: {
                Text("Temperature unit")
                    .font(Font.title)
            } footer:  {
                Text("Metric will display de temperature in Celsius, Imperial in Fahrenheit, and Standard in Kelvin")
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    let viewModel = UnitsViewModel()
    UnitsView(viewModel: viewModel)
}
