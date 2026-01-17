//
//  ListRow.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import SwiftUI

struct ListRow: View {
    var label: String
    var value: String?
    var showChevron: Bool
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            if let value {
                Text(verbatim: value)
            }
            
            if showChevron {
                Image(systemName: "chevron.right")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    ListRow(label: "Units", value: "Metric", showChevron: true)
}
