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

    init() {
        // TODO: - This might break in future versions
        UIRefreshControl.appearance().tintColor = UIColor(.celeste)
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach($moviesStore.movies) { $movie in
                    ZStack {
                        NavigationLink {
                            MovieDetailView($movie)
                        } label: {
                            EmptyView()
                        }
                        MovieRowView(movie)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.background)
                }

                HStack {
                    Text("Loading....")
                        .font(.system(
                            .body,
                            design: .rounded,
                            weight: .semibold)
                        )
                }
                .padding(5)
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.yellow)
                .onAppear {
                    Task {
                        await moviesStore.refreshTopRatedMovies()
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .refreshable {
                await moviesStore.refreshTopRatedMovies()
            }
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
