//
//  MoviesUseCase.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

final class MoviesUseCase: MoviesUseCaseProtocol {

    private let dataSource: MoviesRemoteDataSource

    init() {
        self.dataSource = MoviesRemoteDataSource()
    }

    func getTopRatedMovies(using filter: MoviesFilter) -> RxSwift.Single<MoviesResponse> {
        dataSource.getTopRatedMovies(using: filter)
    }

    func getSimilarMovies() -> RxSwift.Single<MoviesResponse> {
        dataSource.getSimilarMovies()
    }

    func getMovieDetail(_ movieID: String) -> Single<Movie> {
        dataSource.getMovieDetail(movieID)
    }


}
