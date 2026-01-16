//
//  HostingController.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit
import SwiftUI

class HostingController<Content: View, VM: BaseViewModel>: UIHostingController<Content> {
    
    var viewModel: VM
    
    init(rootView: Content, viewModel: VM) {
        self.viewModel = viewModel
        super.init(rootView: rootView)
        viewModel.hostingController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
}
