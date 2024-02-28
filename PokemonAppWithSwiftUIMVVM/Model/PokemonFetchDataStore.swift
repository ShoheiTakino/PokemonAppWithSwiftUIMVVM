//
//  PokemonFetchDataStore.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2024/02/27.
//

import Foundation
import Combine

protocol PokemonFetchDataStoreInput: AnyObject {
    var pokemonListEntityPublisher: Published<[PokemonEntity]>.Publisher { get }
    func fetchPokemonListEntity() async throws
}

final class PokemonFetchDataStore: PokemonFetchDataStoreInput {
    
    @Published var pokemonListEntity: [PokemonEntity] = []
    /// ポケモン図鑑の番号1~151番目のポケモンを取得するためのURLを生成
    private var pokemonUrlList: [URL] = (1...151).map { URL(string: "https://pokeapi.co/api/v2/pokemon/\($0)/")! }

    var pokemonListEntityPublisher: Published<[PokemonEntity]>.Publisher {
        $pokemonListEntity
    }

    /// 実際に1~151までのポケモンのデータを並列処理で取得する関数
    /// ポケモンのデータを全て取得した後にデータを図鑑順にソートする（データは並列処理で順不同で取得するため）
    /// ソート後にデータを全て`pokemonListEntity`に入れてViewModelにデータの変更を知らせる
    func fetchPokemonListEntity() async throws {
        var pokemonListEntity: [PokemonEntity] = []
        do {
            try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                for pokemonUrl in pokemonUrlList {
                    group.addTask {
                        let (data, response) = try await URLSession.shared.data(from: pokemonUrl)
                        return (data, response)
                    }
                }

                for try await (data, _) in group {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(PokemonEntity.self, from: data)
                    pokemonListEntity.append(pokemon)
                }

                pokemonListEntity.sort { $0.id < $1.id }
                self.pokemonListEntity = pokemonListEntity
            }
        } catch {
            throw PokemonFetchError.unknown
        }
    }
}
