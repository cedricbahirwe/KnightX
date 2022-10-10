//
//  MovieRowView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct MovieRowView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 170, height: 170)
                .overlay(content: {
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .black.opacity(0.7)]), startPoint: .center, endPoint: .bottom)
                })
                .cornerRadius(20)
                .foregroundColor(Color("primary.celeste"))
                .overlay(alignment: .bottom) {
                    Text("2022")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Fantastic Beasts: The Crimes of....")
                        .font(.system(
                            .title2,
                            design: .rounded,
                            weight: .semibold)
                        )
                        .lineLimit(2)
                    Text("Lore ipsum lore ipsum\nLore ipsum lore ipsum\nlore ipsum lore ipsum")
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxHeight: .infinity, alignment: .top)

                HStack(spacing: 15) {
                    Spacer()
                    Group {
                        Image("checkmark.fill")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                    }
                    .frame(width: 30)
                    .foregroundColor(Color("primary.celeste"))
                }
            }
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .padding(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 170)
        .background(Color("primaryBackground"))
        .cornerRadius(20)
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            MovieRowView()
                .padding()
        }
//            .preferredColorScheme(.dark)
    }
}
