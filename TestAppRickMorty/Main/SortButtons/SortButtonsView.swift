//
//  SortButtonsView.swift
//  TestAppRickMorty
//
//  Created by NikoS on 02.06.2024.
//

import SwiftUI

struct SortButtonsView: View {
    @State private var selectedButton: String?
    
    let action: ((CharacterStatus) -> Void)
    
    private func buttonText(status: CharacterStatus) -> String {
        return status.rawValue.capitalized
    }
    
    var body: some View {
        HStack(spacing: Style().buttonsSpacing) {
            ForEach(CharacterStatus.allCases, id: \.self) { status in
                CustomButton(isSelected: selectedButton == status.rawValue, title: buttonText(status: status)) {
                    selectedButton == status.rawValue ? (selectedButton = nil) : (selectedButton = status.rawValue)
                    action(status)
                }
            }
        }
    }
}
