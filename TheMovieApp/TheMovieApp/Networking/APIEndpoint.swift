//
//  APIEndpoint.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

enum APIEndpoint: String {
    case topRated = "/movie/top_rated"
    case similarMovies = "/movie/%d/similar"
    case movieDetail = "/movie/%d"

    var baseURL: BaseURL {
        return .moviesDB_url
    }
    enum BaseURL {
        case moviesDB_url
    }
}
