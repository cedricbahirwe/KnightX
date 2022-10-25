//
//  MoviesRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift
import Combine

final class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        <#code#>
    }

    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), APIError> {
        let params: [String: Any] = ["page": page]
        let urlRequest = URLRequest(.topRated, .get, params)
//        return apiRequest(urlRequest)
        let publisher: AnyPublisher<MoviesDataResponse, Error> = apiRequest(.topRated(params))


    }

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        <#code#>
    }

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, Error> {
        <#code#>
    }

    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)> {
        requestTopMovies(page).map({ ($0.0.movies, $0.0.metadata) })
    }

    func getSimilarMovies(_ movieID: Int) -> Single<([Movie], APIMetadata)> {
        requestSimilarMovies(movieID).map({ ($0.0.movies, $0.0.metadata) })
    }

    func getMovieDetail(_ movieID: Int) -> Single<Movie> {
        requestMovieDetail(movieID).map({ $0.0 })
    }
}

private extension MoviesRemoteDataSource {
    func requestTopMovies(_ page: Int) -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let params: [String: Any] = ["page": page]
        let urlRequest = URLRequest(.topRated, .get, params)
        return apiRequest(urlRequest)
    }

    func requestSimilarMovies(_ movieID: Int) -> Single<(MoviesDataResponse, HTTPURLResponse)> {
        let urlRequest = URLRequest(.similarMovies, .get, nil, movieID)
        return apiRequest(urlRequest)
    }

    func requestMovieDetail(_ movieID: Int) -> Single<(Movie, HTTPURLResponse)> {
        let urlRequest = URLRequest(.movieDetail, .get, nil, movieID)
        return apiRequest(urlRequest)
    }
}
