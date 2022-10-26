//
//  MoviesUseCase.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Combine

final class GetMoviesUseCase: GetMoviesUseCaseProtocol {
    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        dataSource.getTopRatedMovies(page)
    }

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        dataSource.getSimilarMovies(movieID)
    }

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, Error> {
        dataSource.getMovieDetail(movieID)
    }

    private let dataSource: MoviesRemoteDataSourceProtocol

    init(_ dataSource: MoviesRemoteDataSourceProtocol = MoviesRemoteDataSource()) {
        self.dataSource = dataSource
    }
}
