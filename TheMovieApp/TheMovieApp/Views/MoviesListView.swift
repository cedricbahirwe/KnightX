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
                    .onAppear {
                        Task {
                            await moviesStore.loadNextPage(movie)
                        }
                    }
                }

                if moviesStore.isLoadingMovies {
                    HStack {
                        Text("Loading....")
                            .font(.system(
                                .body,
                                design: .rounded,
                                weight: .semibold)
                            )
                            .foregroundColor(.celeste)

                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.celeste)
                    }
                    .padding(5)
                    .frame(maxWidth: .infinity)
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
            .toolbar(.hidden)
            .task {
                await moviesStore.getTopRatedMovies()
            }
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
