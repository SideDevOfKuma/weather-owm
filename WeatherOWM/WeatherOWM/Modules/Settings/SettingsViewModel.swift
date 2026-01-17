//
//  SettingsViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import Combine
import UIKit

protocol SettingsNavDelegate: AnyObject {
    func onUnitsTapped()
}

final class SettingsViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: SettingsNavDelegate?
    
    init(navDelegate: SettingsNavDelegate? = nil) {
        self.navDelegate = navDelegate
    }
}

// MARK: - Actions
extension SettingsViewModel {
    func onUnitsTapped() {
        navDelegate?.onUnitsTapped()
    }
}
