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
                ForEach($moviesStore.topRatedMovies) { $movie in
                    ZStack {
                        NavigationLink {
                            MovieDetailView($movie)
                        } label: {
                            EmptyView()
                        }
                        MovieRowView($movie)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.background)
                    .onAppear {
                        if moviesStore.hasReachedEnd(movie) {
                            moviesStore.fetchNextTopRatedMovies()
                        }
                    }
                }

                if moviesStore.loadingState == .small {
                    HStack {
                        Text("Loading....")
                            .font(.system(
                                .body,
                                design: .rounded,
                                weight: .semibold)
                            )
                            .foregroundColor(.celeste)
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
            .overlay(content: {
                if moviesStore.loadingState == .wide {
                    ZStack {
                        DotsActivityView(color: .celeste)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.ultraThinMaterial)
                            .preferredColorScheme(.dark)
                    }
                }
            })
            .alert(item: $moviesStore.alert) { item in
                Alert(
                    title: Text(item.title),
                    message: Text(item.message),
                    dismissButton: .default(
                        Text("Try again!"),
                        action: {
                            item.action?()
                        })
                )
            }
            .refreshable {
                moviesStore.refreshTopRatedMovies()
            }
            .toolbar(.hidden)
        }
    }
}

#if DEBUG
struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
            .environmentObject(MoviesViewModel(getMoviesUseCase: GetMoviesUseCaseMockup()))
    }
}
#endif
