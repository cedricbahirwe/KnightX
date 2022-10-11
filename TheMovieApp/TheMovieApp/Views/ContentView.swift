//
//  ContentView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 09/10/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var store: MoviesViewModel

    init(_ store: MoviesViewModel) {
        self.store = store
    }

    var body: some View {
        MoviesListView()
            .onAppear(perform: store.getTopRatedMovies) 
            .environmentObject(store)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(MoviesViewModel(moviesUseCase: MoviesUseCaseMockup()))
    }
}
#endif
