//
//  UnitsViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import Foundation
import Combine

final class UnitsViewModel: BaseViewModel, ObservableObject {
    var unitOptions: [SelectableUnit] = [
        SelectableUnit(title: "Metric", type: TempUnit.metric),
        SelectableUnit(title: "Imperial", type: TempUnit.imperial),
        SelectableUnit(title: "Standard", type: TempUnit.standard)
    ]
}
