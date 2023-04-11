//
//  Post.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/06.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

struct Pokemon: Decodable, Identifiable {
    let name: String
    let id: Int
    let sprites: Images
    let types: [Types]
    
    struct Images: Codable {
        let frontImage: String
        let shinyImage: String

        enum CodingKeys: String, CodingKey {
            case frontImage = "front_default"
            case shinyImage = "front_shiny"
        }
    }
    
    struct Types: Codable {
        let type: `Type`
    }

    struct `Type`: Codable {
        let name: String
    }
}
