//
//  MovieDetailView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct MovieDetailView: View {
    init(_ movie: Movie) {
        self.movie = movie
    }

    private var movie: Movie
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    .foregroundColor(.gray)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 5) {

                        Text(movie.title)
                            .font(.system(.title,
                                          design: .rounded,
                                          weight: .semibold))

                        Text("Animation, comedy, adventure")
                            .font(.system(.title3,
                                          design: .rounded,
                                          weight: .regular))

                        if let status = movie.status {
                            sectionView("Status:", .init(status))
                        }

                        sectionView("Release year:", "2015.")

                        sectionView("Description:",
                                    "After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions - Joy, Fear, Anger, Disgust and Sadness - conflict on how best to navigate a new city, house, andschool.")
                    }
                    .padding()
                }
                .foregroundColor(Color.foreground)

            }
            .ignoresSafeArea()

            HStack(spacing: 15) {
                BackButton()
                Spacer()
                WatchedStatusView(isOn: true)
                FavouriteStatusView(isOn: true)
            }
            .foregroundColor(.celeste)
            .padding()
        }
        .background(Color.background)
        .toolbar(.hidden)
    }

    private func sectionView(_ title: LocalizedStringKey, _ content: LocalizedStringKey) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(.title2, design: .rounded, weight: .semibold))
            Text(content)
                .font(.system(.title3, design: .rounded, weight: .regular))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(.example)
    }
}
#endif
