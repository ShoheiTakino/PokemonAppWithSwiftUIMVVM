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
