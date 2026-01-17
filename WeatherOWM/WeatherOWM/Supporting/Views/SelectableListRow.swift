//
//  SelectableListRow.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 16/01/2026.
//

import SwiftUI

struct SelectableListRow: View {
    var title: String
    var isSelected: Bool = false
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            if isSelected {
                Image(systemName: "circle.fill")
                    .foregroundStyle(Color("PrimaryColor"))
            } else {
                Image(systemName: "circle")
                    .foregroundStyle(Color("PrimaryColor"))
            }
            Text(title)
                .font(isSelected ? Font.body.bold(): Font.body)
            Spacer()
            
        }
        .padding()
        .cornerRadius(12)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    SelectableListRow(title: "Item 1", isSelected: true)
}
