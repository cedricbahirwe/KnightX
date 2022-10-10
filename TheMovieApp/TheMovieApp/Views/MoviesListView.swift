//
//  MoviesListView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct MoviesListView: View {
    var body: some View {
        ZStack {
            List(1..<100) { row in
                MovieRowView()
                    .listRowBackground(Color.red)
            }
            .listStyle(.plain)
            .refreshable {
                print("Do your refresh work here")
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
