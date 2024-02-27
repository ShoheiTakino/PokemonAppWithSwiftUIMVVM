//
//  GridItems.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2024/02/27.
//

import SwiftUI

struct GridItems {

    // ポケモンボールを2列にするためのGridItem
    static var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .center), count: 2)
}
