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

    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)> {
        dataSource.getTopRatedMovies(page)
    }

    func getSimilarMovies(_ page: Int) -> Single<([Movie], APIMetadata)> {
        dataSource.getSimilarMovies(page)
    }

    func getMovieDetail(_ movieID: Int) -> Single<Movie> {
        dataSource.getMovieDetail(movieID)
    }
}
