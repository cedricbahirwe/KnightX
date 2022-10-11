//
//  MovieRowView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRowView: View {
    private let movie: Movie

    init(_ movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        HStack(spacing: 0) {
            imageView

            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    titleView
                    descriptionView
                }
                .frame(maxHeight: .infinity, alignment: .top)

                statusView
            }
            .font(.system(.body, design: .rounded))
            .foregroundColor(Color.foreground)
            .padding(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 170)
        .background(Color.rowBackground)
        .cornerRadius(20)
    }
}

extension MovieRowView {
    var imageView: some View {
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
                ZStack {
                    if let year = movie.releaseDateFormatted {
                        Text(year.formatted(.dateTime.year()))
                            .font(.system(.title2, design: .rounded, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
    }

    var titleView: some View {
        Text(movie.title)
            .font(.system(
                .title2,
                design: .rounded,
                weight: .semibold)
            )
            .lineLimit(2)
    }

    var descriptionView: some View {
        Text(movie.overview)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
    }

    var statusView: some View {
        HStack(spacing: 15) {
            Spacer()
            Group {
                WatchedStatusView(isOn: movie.isWatched)
                FavouriteStatusView(isOn: movie.isFavourite)
            }
            .frame(width: 30)
            .foregroundColor(Color("primary.celeste"))
        }
    }
}

#if DEBUG
struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(.example)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
