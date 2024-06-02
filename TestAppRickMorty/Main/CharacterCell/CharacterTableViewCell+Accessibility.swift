//
//  CharacterTableViewCell+Accessibility.swift
//  TestAppRickMorty
//
//  Created by NikoS on 03.06.2024.
//

import Foundation

extension CharacterTableViewCell {
    
    enum AccessibilityID: Identifiable {
        case cellView
        case characterNameLabel
        case characterSpeciesLabel
        case characterImageView
        case roundedBackgroundView
    }

    func configureAccessibility() {
        contentView.accessibilityIdentifier = AccessibilityID
            .cellView
            .identifier
        
        characterNameLabel.accessibilityIdentifier = AccessibilityID
            .characterNameLabel
            .identifier
        
        characterSpeciesLabel.accessibilityIdentifier = AccessibilityID
            .characterSpeciesLabel
            .identifier
        
        characterImageView.accessibilityIdentifier = AccessibilityID
            .characterImageView
            .identifier
        
        roundedBackgroundView.accessibilityIdentifier = AccessibilityID
            .roundedBackgroundView
            .identifier
    }
}
