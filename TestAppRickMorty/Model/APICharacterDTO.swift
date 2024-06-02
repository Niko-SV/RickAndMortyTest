//
//  APICharacterDTO.swift
//  TestAppRickMorty
//
//  Created by NikoS on 27.05.2024.
//

import Foundation

struct APICharacterDTO: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let location: CharacterLocation
    let image: String
    let url: String
}

enum CharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}
