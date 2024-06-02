//
//  SortButton.swift
//  TestAppRickMorty
//
//  Created by NikoS on 29.05.2024.
//

import SwiftUI

struct CustomButton: View {
    let isSelected: Bool
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .foregroundColor(.black)
                .padding(.horizontal, Style().padding)
                .padding(.vertical, Style().padding)
                .background(isSelected ? Style().selectedButtonColor : Style().deselectedButtonColot)
                .clipShape(Capsule())
                .overlay(
                    RoundedRectangle(cornerRadius: Style().cornerRadius)
                        .stroke(Style().tintColor, lineWidth: Style().tintWidth)
                )
        }
        .accessibilityIdentifier("\(title)SortingButton")
    }
}
