//
//  CharacterTableViewCellViewModel.swift
//  TestAppRickMorty
//
//  Created by NikoS on 30.05.2024.
//

import Foundation

final class CharacterTableViewCellViewModel: Hashable, Equatable {
    
    private let characterImageUrl: URL?
    
    public let id: Int
    public let characterName: String
    public let characterSpecies: String
    public let characterStatus: CharacterStatus
    
    init(
        id: Int,
        characterName: String,
        characterSpecies: String,
        characterStatus: CharacterStatus,
        characterImageUrl: URL?
    ) {
        self.id = id
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterSpecies = characterSpecies
        self.characterImageUrl = characterImageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageManager.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: CharacterTableViewCellViewModel, rhs: CharacterTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(characterName)
        hasher.combine(characterSpecies)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
