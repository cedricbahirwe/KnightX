//
//  MoviesListView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct MoviesListView: View {
    @EnvironmentObject
    private var moviesStore: MoviesViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(moviesStore.movies) { movie in
                    ZStack {
                        NavigationLink {
                            MovieDetailView(movie)
                        } label: {
                            EmptyView()
                        }
                        MovieRowView(movie)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.background)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .refreshable {
                await moviesStore.refreshTopRatedMovies()
            }
            .tint(.red)
            .toolbar(.hidden)
        }
    }
}

#if DEBUG
struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
            .environmentObject(MoviesViewModel(moviesUseCase: MoviesUseCaseMockup()))
    }
}
#endif
