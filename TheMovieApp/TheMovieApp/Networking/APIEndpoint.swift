//
//  APIEndpoint.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

enum APIEndpoint: String {
    case topRated = "top_rated"

    var baseURL: BaseURL {
        return .moviesDB_url
    }
    enum BaseURL {
        case moviesDB_url

    }
}
