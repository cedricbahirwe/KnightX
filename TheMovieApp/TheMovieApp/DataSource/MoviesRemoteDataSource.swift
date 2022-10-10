//
//  MoviesRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

final class MoviesRemoteDataSource: BaseRemoteDataSource {
    func getTopRatedMovies(using filter: MoviesFilter) -> Single<MoviesResponse> {
        requestMovies(filter).map({ $0.0 })
    }

    func getSimilarMovies() -> Single<MoviesResponse> {
        requestSimilarMovies().map({ $0.0 })
    }

    func getMovieDetail(_ movieID: String) -> Single<Movie> {
        requestMovieDetail().map({ $0.0 })
    }

}

private extension MoviesRemoteDataSource {
    func requestMovies(_ filter: MoviesFilter) -> Single<(MoviesResponse, HTTPURLResponse)> {
        let params = filter.getParameters()
        let urlRequest = URLRequest(.topRated, .get, params)
        return apiRequest(urlRequest)
    }


    func requestSimilarMovies() -> Single<(MoviesResponse, HTTPURLResponse)> {
        let urlRequest = URLRequest(.similar, .get)
        return apiRequest(urlRequest)
    }

    func requestMovieDetail() -> Single<(Movie, HTTPURLResponse)> {
        let urlRequest = URLRequest(.detail, .get)
        return apiRequest(urlRequest)
    }
}

struct MoviesFilter {
    var limit: Int? // between 1 - 50 (inclusive) The limit of results per page that has been set
    var page: Int? // 1Used to see the next page of movies, eg limit=15 and page=2 will show you movies 15-30
//    var quality: TorrentQuality? // (720p, 1080p, 2160p, 3D)    All    Used to filter by a given quality

    var minimum_rating: Int? // between 0 - 9 (inclusive)    0    Used to filter movie by a given minimum IMDb ratinga
    var query_term: String? //  0    Used for movie search, matching on: Movie Title/IMDb Code, Actor Name/IMDb Code, Director Name/IMDb Code
    var genre: Genre? // Used to filter by a given genre (See http://www.imdb.com/genre/ for full list)

    var sort_by: SortBy? // Sorts the results by choosen value
    var order_by: Order? //  Orders the results by either Ascending or Descending order
    var with_rt_ratings: Bool? = false // Returns the list with the Rotten Tomatoes rating included

    func getParameters() -> [String: Any] {
        var params = [String: Any]()

        if let limit { params["limit"] = limit }
        if let page { params["page"] = page }
//        if let quality { params["quality"] = quality.rawValue }

        if let minimum_rating { params["minimum_rating"] = minimum_rating }
        if let query_term { params["query_term"] = query_term }
        if let genre { params["genre"] = genre.rawValue }

        if let sort_by { params["sort_by"] = sort_by.rawValue }
        if let order_by { params["order_by"] = order_by.rawValue }
        if let with_rt_ratings { params["with_rt_ratings"] = with_rt_ratings }

        return params
    }
}

extension MoviesFilter {
    enum Genre: String {
        case all = "All"
        case comedy
        case scifi = "sci-fi"
        case horror
        case romance
        case action
        case thriller
        case drama
        case mystery
        case crime
        case animation
        case adventure
        case fantasy
        case comedyRomance = "comedy-romance"
        case actionComedy = "action-comedy"
        case superhero
    }

    enum Order: String {
        case ascending = "asc"
        case descending = "desc"
    }

    enum SortBy: String {
        case title, year, rating, peers, seeds, download_count, like_count, date_added
    }
}
