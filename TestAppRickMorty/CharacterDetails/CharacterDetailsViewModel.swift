//
//  CharacterDetailsViewModel.swift
//  TestAppRickMorty
//
//  Created by NikoS on 01.06.2024.
//

import Foundation
import SwiftUI

final class CharacterDetailsViewModel: ObservableObject {
    @Published private var character: APICharacterDTO
    weak var coordinator: AppCoordinator?
    
    init(character: APICharacterDTO) {
        self.character = character
    }
    
    var name: String {
        character.name
    }
    
    var species: String {
        character.species.capitalized
    }
    
    var status: String {
        character.status.rawValue.capitalized
    }
    
    var gender: String {
        character.gender.rawValue.capitalized
    }
    
    var location: String {
        character.location.name
    }
    
    var image: String {
        character.image
    }
    
    func goToMain(){
        coordinator?.goToMain()
    }
}
