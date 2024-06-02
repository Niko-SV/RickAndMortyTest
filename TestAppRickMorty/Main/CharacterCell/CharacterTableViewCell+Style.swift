//
//  CharacterTableViewCell+Style.swift
//  TestAppRickMorty
//
//  Created by NikoS on 30.05.2024.
//

import UIKit

extension CharacterTableViewCell {
    struct Style {
        let mainTextTopConstraint: CGFloat = 5
        let secondaryTextTopConstraint: CGFloat = 10
        let textLeadingConstraint: CGFloat = 20
        let roundedViewWidthContraint: CGFloat = 16
        let roundedViewHeightContraint: CGFloat = 5
        let imageViewConstraint: CGFloat = 20
        let imageViewSize: CGFloat = 100
        let cornerRadius: CGFloat = 20
        let roundedViewBorderWith: CGFloat = 1
        let emptyRoundedViewBorderWith: CGFloat = 0
        let mainTextFont: UIFont.Weight = .bold
        let mainTextFontSize: CGFloat = 20
        let secondaryTextFont: UIFont.Weight = .semibold
        let secondaryTextFontSize: CGFloat = 18
        let mainTextColor: UIColor = .black
        let secondaryTextColor: UIColor = .gray
        let roundedViewTintColor: UIColor = .lightGray
        let firstStatusBackgroundColor: UIColor = UIColor(red: 254/255, green: 226/255, blue: 240/255, alpha: 1)
        let secondStatusBackgroundColor: UIColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        let thirdStatusBackgroundColor: UIColor = .white
    }
}

