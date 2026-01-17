//
//  LocationAuthorizationRequestViewModel.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import Combine
import UIKit

protocol LocationAuthorizationNavDelegate: AnyObject {
    func onMaybeLaterTapped()
    func onLocalizationAuthorizationRequestTapped()
}

final class LocationAuthorizationViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: LocationAuthorizationNavDelegate?
    
    init(navDelegate: LocationAuthorizationNavDelegate? = nil) {
        self.navDelegate = navDelegate
    }
}

// MARK: - Actions
extension LocationAuthorizationViewModel {
    func onMaybeLaterTapped() {
        navDelegate?.onMaybeLaterTapped()
    }
    
    func onLocalizationAuthorizationRequestTapped() {
        navDelegate?.onLocalizationAuthorizationRequestTapped()
    }
}
