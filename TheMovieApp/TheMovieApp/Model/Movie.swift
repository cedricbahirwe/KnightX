//
//  Movie.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    var isWatched: Bool = false
    var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    var releaseDateFormatted: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter.date(from: releaseDate)
    }

    var status: String? {
        if let releaseDateFormatted {
            return releaseDateFormatted > Date.now ? "Pending" : "Released"
        } else {
            return "Unknown"
        }
    }

    var fullPosterPath: String? {
        if let path = (posterPath ?? backdropPath) {
            return AppConstants.moviesImageBaseURL + path
        } else {
            return nil
        }
    }
}
