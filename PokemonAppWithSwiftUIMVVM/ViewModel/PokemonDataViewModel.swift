//
//  PokemonDataViewModel.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI
import Combine

// UIの更新はメインスレッドで行う必要があるため、MainActorを使用してプロパティを画面に反映する際にメインスレッドで実行するように指定
@MainActor
final class PokemonDataViewModel: ObservableObject {

    // @Publishedは、ObservableObjectに準拠しているクラス内で使用するプロパティを監視(データバインディング)するためのプロパティラッパー
    @Published var pokemonList: [PokemonEntity] = []
    @Published var selectedPokemon: PokemonEntity? = nil
    @Published var isNavigateToDetailView = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isActiveAlert = false
    private var cancelabel: Set<AnyCancellable> = []
    private let dataStore: PokemonFetchDataStoreInput

    init(dataStore: PokemonFetchDataStoreInput = PokemonFetchDataStore()) {
        self.dataStore = dataStore
        // PokemonFetchDataStoreで監視する値を指定して、その値が変更されたことをViewModelで検知するために使用するための実装
        // キーワードは、『Combine』『Publisher』『Subscriber』『Operator』『データ駆動型開発』
        dataStore.pokemonListEntityPublisher
            .receive(on: DispatchQueue.main)
            .filter { !$0.isEmpty }
            .assign(to: \.pokemonList, on: self)
            .store(in: &cancelabel)
        fetchPokemonListEntity()
    }

    /// 表示されているポケモンもしくはモンスターボールをタップした時に発火させる関数
    /// 画面遷移までがこの関数の役目
    func tappedAtMonsterBallWith(_ pokemon: PokemonEntity) {
        selectedPokemon = pokemon
        isNavigateToDetailView = true
    }

    /// ScrollViewでPullされた時に再度ポケモンのデータを取得しに行くための処理
    func pulledToRefreshed() {
        fetchPokemonListEntity()
    }
}

// MARK: - Pirvate

private extension PokemonDataViewModel {

    /// ポケモンのデータを取得しに行くための関数で、
    /// Taskで非同期関数を呼び出すことを宣言し、実際の処理は別クラスで行う
    /// キーワード『do/catch(エラーハンドリング、失敗可能性のある処理の呼び出し)』
    func fetchPokemonListEntity() {
        Task {
            do {
                try await dataStore.fetchPokemonListEntity()
            } catch {
                // サーバーからのデータ取得処理に失敗した場合はユーザーに知らせる
                alertTitle = "ポケモンの取得に失敗"
                alertMessage = "再度お確かめください。"
                isActiveAlert = true
            }
        }
    }
}
