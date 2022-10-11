//
//  MoviesRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

final class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies(_ page: Int) -> RxSwift.Single<([Movie], APIMetadata)> {
        requestTopMovies(page).map({ ($0.0.movies, $0.0.metadata) })
    }

    func getSimilarMovies(_ page: Int) -> RxSwift.Single<([Movie], APIMetadata)> {
        requestSimilarMovies(page).map({ ($0.0.movies, $0.0.metadata) })
    }

    func getMovieDetail(_ movieID: Int) -> RxSwift.Single<Movie> {
        requestMovieDetail(movieID).map({ $0.0 })
    }
}

private extension MoviesRemoteDataSource {
    func requestTopMovies(_ page: Int) -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let params: [String: Any] = ["page": page]
        let urlRequest = URLRequest(.topRated, .get, params)
        return apiRequest(urlRequest)
    }

    func requestSimilarMovies(_ page: Int) -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let params: [String: Any] = ["page": page]
        let urlRequest = URLRequest(.similar, .get, params)
        return apiRequest(urlRequest)
    }

    func requestMovieDetail(_ movieID: Int) -> Single<(Movie, HTTPURLResponse)> {
        let urlRequest = URLRequest(.detail, .get)
        return apiRequest(urlRequest)
    }
}
