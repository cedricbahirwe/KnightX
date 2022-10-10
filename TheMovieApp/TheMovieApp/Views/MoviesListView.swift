//
//  MoviesListView.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import SwiftUI

struct MoviesListView: View {
    struct NewsItem: Decodable, Identifiable {
        let id: Int
        let title: String
        let strap: String
    }

    @State private var movies = 10
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<movies, id:\.self) { row in
                    ZStack {
                        NavigationLink {
                            MovieDetailView()
                        } label: {
                            EmptyView()
                        }
                        MovieRowView()
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.background)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .refreshable {
                do {
                    let url = URL(string: "https://www.hackingwithswift.com/samples/news-1.json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    movies += try JSONDecoder().decode([NewsItem].self, from: data).count / 2
                } catch {}
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
    }
}
#endif
