//
//  MoviesUseCase.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift

final class MoviesUseCase: MoviesUseCaseProtocol {
    private let dataSource: MoviesRemoteDataSourceProtocol

    init(_ dataSource: MoviesRemoteDataSourceProtocol = MoviesRemoteDataSource()) {
        self.dataSource = dataSource
    }

    func getTopRatedMovies() -> Single<([Movie], APIMetadata)> {
        dataSource.getTopRatedMovies()
    }

    func getSimilarMovies() -> Single<([Movie], APIMetadata)> {
        dataSource.getSimilarMovies()
    }

    func getMovieDetail(_ movieID: String) -> Single<Movie> {
        dataSource.getMovieDetail(movieID)
    }
}
