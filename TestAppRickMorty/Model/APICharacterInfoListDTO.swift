//
//  APICharacterInfoListDTO.swift
//  TestAppRickMorty
//
//  Created by NikoS on 29.05.2024.
//

import Foundation

struct APICharacterInfoListDTO: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [APICharacterDTO]
}
