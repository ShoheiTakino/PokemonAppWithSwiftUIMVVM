//
//  PokemonLazyVGridView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct PokemonLazyVGridView: View {
    // @StateObjectは、SwiftUIで使用されるプロパティラッパーでSwiftUIアプリケーションにおける状態管理するらしい
    @StateObject var viewModel = PokemonDataViewModel()
    // 長押しでポケモンの色違いを出現させるためのBool
    @State private var isLongpressed = false
    // ポケモンボールを2列にするためのGridItem
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 10,
                                                             alignment: .center),
                                            count: 2)
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        // NavigationStackでNavigationTitleと、push遷移を可能にする
        NavigationStack {
            // スクロールビューにする処理
            ScrollView(.vertical) {
                // UIKitでいう、CollectionViewとほぼ同義である
                // CollectionViewでは、Cellを使用するが、LazyVGridでは違うみたい
                LazyVGrid(columns: columns) {
                    // リクエストで取得したポケモンの数、GridItemを生成する
                    ForEach((0..<viewModel.pokemonList.count), id: \.self) { index in
                        // 各GridItemをタップすると、対応するポケモンの詳細画面に(NavigationControllerでいう)pushする処理
                        NavigationLink(destination: PokemonDetailView(pokemon: viewModel.pokemonList[index])) {
                            // 非同期的に画像を読み込み表示するためのビューで他にも色々とオプションがある
                            AsyncImage(url: URL(string: switchPokemonImage(isNomal: isLongpressed, images: viewModel.pokemonList[index]))) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: screenWidth / 3)
                                // 画像をロングプレスすると色違いになるが、このモディファイアのせいで、画面遷移できなくなるよ
//                                    .onLongPressGesture() {
//                                        isLongpressed.toggle()
//                                    }
                                // 画像が表示されるまでは、ProgressView()を表示する
                            } placeholder: {
                                ProgressView()
                            }
                            // モンスターボールの大きさを決定する処理
                            .padding()
                            .frame(width: screenWidth / 2.1, height: 200)
                            .background {
                                ZStack {
                                    // 上半分を赤色にする処理
                                    Circle()
                                        .fill(Color.red)
                                        .frame(height: screenWidth / 2)
                                    // 下半分を白にする処理
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: screenWidth / 2.1)
                                        .offset(y: screenWidth / 4)
                                }
                            }
                            // モンスターボールの枠を黒にする処理
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("一覧(GridLayout)")
            // ナビゲーションバーのタイトルの大きさを変更する処理で、NavigationBarItem.TitleDisplayMode
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonData()
            }
        }
    }
    
    /// ロングプレスで画像を変更する処理
    private func switchPokemonImage(isNomal: Bool, images: Pokemon) -> String {
        let imageString = isNomal ? images.sprites.shinyImage : images.sprites.frontImage
        return imageString
    }
}

//struct PokemonLazyVGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonLazyVGridView()
//    }
//}
