//
//  MoviesRemoteDataSourceProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import RxSwift
import Combine

protocol MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)>

    func getSimilarMovies(_ movieID: Int) -> Single<([Movie], APIMetadata)>

    func getMovieDetail(_ movieID: Int) -> Single<Movie>

    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), APIError>

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), APIError>

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, APIError>
}
