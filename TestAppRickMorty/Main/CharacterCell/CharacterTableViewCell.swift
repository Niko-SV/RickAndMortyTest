//
//  CharacterTableViewCell.swift
//  TestAppRickMorty
//
//  Created by NikoS on 30.05.2024.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    static let cellIdentifier = "CharacterTableViewCell"
    
    let characterNameLabel = UILabel()
    let characterSpeciesLabel = UILabel()
    let characterImageView = UIImageView()
    let roundedBackgroundView = UIView()
    
    var characterStatus: CharacterStatus = .alive
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.layer.cornerRadius = Style().cornerRadius
        
        characterNameLabel.font = .systemFont(ofSize: Style().mainTextFontSize, weight: Style().mainTextFont)
        characterNameLabel.textColor = Style().mainTextColor
        
        characterSpeciesLabel.font = .systemFont(ofSize: Style().secondaryTextFontSize, weight: Style().secondaryTextFont)
        characterSpeciesLabel.textColor = Style().secondaryTextColor
        
        roundedBackgroundView.layer.cornerRadius = Style().cornerRadius
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(characterNameLabel)
        roundedBackgroundView.addSubview(characterSpeciesLabel)
        roundedBackgroundView.addSubview(characterImageView)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Style().roundedViewHeightContraint),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style().roundedViewWidthContraint),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Style().roundedViewWidthContraint),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Style().roundedViewHeightContraint),
            
            characterImageView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: Style().imageViewConstraint),
            characterImageView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: Style().imageViewConstraint),
            characterImageView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -Style().imageViewConstraint),
            characterImageView.widthAnchor.constraint(equalToConstant: Style().imageViewSize),
            characterImageView.heightAnchor.constraint(equalToConstant: Style().imageViewSize),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: Style().mainTextTopConstraint),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: Style().textLeadingConstraint),
            characterNameLabel.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -Style().textLeadingConstraint),
            
            characterSpeciesLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: Style().secondaryTextTopConstraint),
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: Style().textLeadingConstraint)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterNameLabel.text = nil
        characterSpeciesLabel.text = nil
        characterImageView.image = nil
    }
    
    public func configure(with viewModel: CharacterTableViewCellViewModel) {
        characterNameLabel.text = viewModel.characterName
        characterSpeciesLabel.text = viewModel.characterSpecies
        characterStatus = viewModel.characterStatus
        switch characterStatus {
        case .alive:
            roundedBackgroundView.backgroundColor = Style().firstStatusBackgroundColor
            roundedBackgroundView.layer.borderWidth = Style().emptyRoundedViewBorderWith
        case .dead:
            roundedBackgroundView.backgroundColor = Style().secondStatusBackgroundColor
            roundedBackgroundView.layer.borderWidth = Style().emptyRoundedViewBorderWith
        case .unknown:
            roundedBackgroundView.backgroundColor = Style().thirdStatusBackgroundColor
            roundedBackgroundView.layer.borderWidth = Style().roundedViewBorderWith
            roundedBackgroundView.layer.borderColor = Style().roundedViewTintColor.cgColor
        }
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.characterImageView.image = image
                }
            case .failure(_):
                break
            }
        }
    }
    
}
