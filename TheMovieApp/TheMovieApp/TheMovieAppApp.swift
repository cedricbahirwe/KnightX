//
//  TheMovieAppApp.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 09/10/2022.
//

import SwiftUI

@main
struct TheMovieAppApp: App {
    @StateObject private var moviesStore = MoviesViewModel(moviesUseCase: MoviesUseCaseMockup())
    var body: some Scene {
        WindowGroup {
            ContentView(moviesStore)
        }
    }
}
