//
//  MoviesUseCase.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift
import Combine

final class GetMoviesUseCase: GetMoviesUseCaseProtocol {
    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), APIError> {
        dataSource.getTopRatedMovies(page)
    }

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), APIError> {
        dataSource.getSimilarMovies(movieID)
    }

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, APIError> {
        dataSource.getMovieDetail(movieID)
    }

    private let dataSource: MoviesRemoteDataSourceProtocol

    init(_ dataSource: MoviesRemoteDataSourceProtocol = MoviesRemoteDataSource()) {
        self.dataSource = dataSource
    }

    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)> {
        dataSource.getTopRatedMovies(page)
    }

    func getSimilarMovies(_ movieID: Int) -> Single<([Movie], APIMetadata)> {
        dataSource.getSimilarMovies(movieID)
    }

    func getMovieDetail(_ movieID: Int) -> Single<Movie> {
        dataSource.getMovieDetail(movieID)
    }
}
