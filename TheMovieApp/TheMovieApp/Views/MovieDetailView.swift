//
//  MovieDetailView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @EnvironmentObject private var moviesStore: MoviesViewModel
    @Binding var movie: Movie
    init(_ movie: Binding<Movie>) {
        _movie = movie
    }

    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 0) {
                WebImage(url: URL(string: movie.fullPosterPath ?? ""))
                    .resizable()
                    .placeholder(Image(systemName: "photo.fill").resizable())
                    .indicator(.activity(style: .large))
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 270)
                    .clipped()
                    .cornerRadius(30)
                    .foregroundColor(.celeste)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {

                        Text(movie.title)
                            .font(.system(.title,
                                          design: .rounded,
                                          weight: .semibold))

                        HStack {
                            Text("Vote:")
                                .font(.system(.title2,
                                              design: .rounded,
                                              weight: .semibold))

                            Text((movie.voteAverage/10).formatted(.percent))
                                .font(.system(.title3,
                                              design: .rounded,
                                              weight: .regular))
                        }

                        if let status = movie.status {
                            sectionView("Status:", .init(status))
                        }

                        if let year = movie.releaseDateFormatted {
                            sectionView("Release year:", "\(year.formatted(.dateTime.year())).")
                        }

                        sectionView("Description:", .init(movie.overview))


                        Section.init {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(moviesStore.similarMovies) { movie in
                                        MovieRowView.init(.constant(movie))
                                    }
                                }
                            }
                        } header: {
                            Text("Similar Movies")
                                .font(.system(.title,
                                              design: .rounded,
                                              weight: .semibold))
                        }
                        .task {
                            await moviesStore.fetchSimilarMovies(to: movie)
                        }

                    }
                    .padding()
                }
                .foregroundColor(Color.foreground)

            }
            .ignoresSafeArea()

            HStack(spacing: 15) {
                BackButton()
                Spacer()
                WatchedStatusView(isOn: movie.isWatched)
                    .onTapGesture {
                        movie.isWatched.toggle()
                    }
                FavouriteStatusView(isOn: movie.isFavourite)
                    .onTapGesture {
                        movie.isFavourite.toggle()
                    }
            }
            .foregroundColor(.celeste)
            .padding()
        }
        .background(Color.background)
        .onDisappear(perform: moviesStore.clearSimilarMovies)
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
        MovieDetailView(.constant(.example))
    }
}
#endif
