//
//  CharacterDetailsViewController+Style.swift
//  TestAppRickMorty
//
//  Created by NikoS on 02.06.2024.
//

import SwiftUI

extension CharacterDetailsView {
    struct Style {
        let cornerRadius: CGFloat = 50
        let nameTextFontSize: CGFloat = 30
        let statusTextFontSize : CGFloat = 15
        let circleSize: CGFloat = 5
        let horizontalStatusTextPaddings: CGFloat = 10
        let verticalStatusTextPaddings: CGFloat = 5
        let hStackSpacer: CGFloat = 8
        let speciesAndGenderHStackSpacer: CGFloat = 4
        let locationSpacer: CGFloat = 10
        let customBackButtonPaddings: CGFloat = 10
        let statusTextOffset: CGFloat = -9
        let customBackButtonForegroundColor: Color = .black
        let customBackButtonBackgroundColor: Color = .white
        let speciesTextColor: Color = .gray
        let genderTextColor: Color = .gray
        let locationTitleTextColor: Color = .black
        let locationTextColor: Color = .gray
        let circleColor: Color = .gray
        let statusRoundedRectangleColor: Color = .blue
    }
}
