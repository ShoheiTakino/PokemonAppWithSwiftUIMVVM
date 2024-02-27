//
//  PokemonLazyVGridView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct PokemonLazyVGridView: View {

    // @StateObjectでObservebleObjectに準拠したクラスのデータを監視(バインディング)できるようにするための
    // プロパティラッパー。 @ObservedObjectを使用すると画面の再描画が何度も走るため、@StateObjectの使用を推奨
    @StateObject var viewModel = PokemonDataViewModel()

    var body: some View {
        // NavigationStackでNavigationTitleと、push遷移を可能にする
        NavigationStack {
            // 画面の大きさを取得するためのツールで、'geometory.size.width'or`geometory.size.height`のような形で画面を取得できる
            GeometryReader { geometory in
                // ScrollViewでネストされたコンテンツをスクロールできるようにするためのUIパーツで、`.vertical`でスクロールの向きを指定する
                ScrollView(.vertical) {
                    // 指定された要素を縦に並べるためのUIパーツで、画面に表示されるタイミングで初めて画面の作成処理が走る
                    LazyVGrid(columns: GridItems.columns) {
                        // 引数に持たせた要素数分、ネストしているアイテムを生成してくれるUIパーツで、
                        // この場合はpokeminList内のpokemon要素を1つずつ画面に流す役割がある。
                        ForEach(viewModel.pokemonList) { pokemon in
                            // 各要素ごとに取得したPokemon型から、ポケモンを表示するためのアイテムを生成する子View
                            PokemonItemView(geometory: geometory, pokemonEntity: pokemon) { pokeon in
                                viewModel.tappedAtMonstarBallWith(pokeon)
                            }
                        }
                    }
                }
            }
            // ナビゲーションタイトルの表示を行うモディファイア
            .navigationBarTitle("一覧(GridLayout)")
            // ナビゲーションバーのタイトルの大きさを変更するモディファイア
            .navigationBarTitleDisplayMode(.inline)
            // 画面遷移を指定できるモディファイア
            .navigationDestination(isPresented: $viewModel.isNavigateToDetaileView) {
                if let selectedPokemon = viewModel.selectedPokemon {
                    PokemonDetailView(pokemon: selectedPokemon)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonData()
            }
        }
    }
}

struct PokemonLazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonLazyVGridView()
    }
}
