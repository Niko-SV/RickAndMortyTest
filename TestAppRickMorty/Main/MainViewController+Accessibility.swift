//
//  MainViewController+Accessibility.swift
//  TestAppRickMorty
//
//  Created by NikoS on 02.06.2024.
//

import Foundation

extension MainViewController {
    
    enum AccessibilityID: Identifiable {
        case mainView
        case titleLabel
        case tableView
    }

    func configureAccessibility() {
        view.accessibilityIdentifier = AccessibilityID
            .mainView
            .identifier
        
        titleLabel.accessibilityIdentifier = AccessibilityID
            .titleLabel
            .identifier
        
        tableView.accessibilityIdentifier = AccessibilityID
            .tableView
            .identifier
    }
}

