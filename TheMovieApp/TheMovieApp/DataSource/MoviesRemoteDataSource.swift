//
//  MoviesRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

final class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies() -> Single<([Movie], APIMetadata)> {
        requestMovies().map({ ($0.0.movies, $0.0.metadata) })
    }

    func getSimilarMovies() -> Single<([Movie], APIMetadata)> {
        requestSimilarMovies().map({ ($0.0.movies, $0.0.metadata) })
    }

    func getMovieDetail(_ movieID: String) -> Single<Movie> {
        requestMovieDetail().map({ $0.0 })
    }
}

private extension MoviesRemoteDataSource {
    func requestMovies() -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let urlRequest = URLRequest(.topRated, .get)
        return apiRequest(urlRequest)
    }

    func requestSimilarMovies() -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let urlRequest = URLRequest(.similar, .get)
        return apiRequest(urlRequest)
    }

    func requestMovieDetail() -> Single<(Movie, HTTPURLResponse)> {
        let urlRequest = URLRequest(.detail, .get)
        return apiRequest(urlRequest)
    }
}
