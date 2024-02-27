//
//  PokemonItemView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2024/02/27.
//

import SwiftUI

struct PokemonItemView: View {

    let geometory: GeometryProxy
    let pokemonEntity: Pokemon
    let action: (Pokemon) -> Void

    var body: some View {
        Button {
            action(pokemonEntity)
        } label: {
            // 非同期的に画像を読み込み表示するためのビューで他にも色々とオプションがある
            AsyncImage(url: URL(string: pokemonEntity.sprites.frontImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometory.size.width / 3)
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
            .frame(width: geometory.size.width / 2.1, height: 200)
            .background {
                ZStack {
                    // 上半分を赤色にする処理
                    Circle()
                        .fill(Color.red)
                        .frame(height: geometory.size.width / 2)
                    // 下半分を白にする処理
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometory.size.width / 2.1)
                        .offset(y: geometory.size.width / 4)
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
