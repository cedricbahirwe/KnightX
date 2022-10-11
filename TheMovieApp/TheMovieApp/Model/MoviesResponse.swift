//
//  MoviesResponse.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

struct MoviesDataResponse: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    var metadata: APIMetadata {
        APIMetadata(currentPage: page, lastPage: totalPages)
    }
}
