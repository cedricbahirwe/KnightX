//
//  FavouriteStatusView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct FavouriteStatusView: View {
    init(isOn: Bool, _ size: CGFloat = 30) {
        self.isOn = isOn
        self.size = size
    }

    private var isOn: Bool
    private var size: CGFloat
    var body: some View {
        Image(systemName: isOn ? "star.fill" : "star")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: size)
    }
}

#if DEBUG
struct FavouriteStatusView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteStatusView(isOn: false)
            .previewLayout(.sizeThatFits)
    }
}
#endif
