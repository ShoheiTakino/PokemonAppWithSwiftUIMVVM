import SwiftUI

struct FavoriteButtonView: View {
    let isFavorite: Bool
    let onTapFavoriteButton: () -> Void

    private enum SystemNameConst {
        static let normalStyle = "heart"
        static let fillStyle = "heart.fill"
    }

    private enum ColorConst {
        static let favorite: Color = .pink
        static let nonFavorite: Color = .gray
    }

    var body: some View {
        Button(action: {
            onTapFavoriteButton()
        }) {
            Image(systemName: isFavorite ? SystemNameConst.fillStyle : SystemNameConst.normalStyle)
                .resizable()
                .foregroundStyle(isFavorite ? ColorConst.favorite : ColorConst.nonFavorite)
                .frame(width: 20, height: 20)
        }
    }
}
