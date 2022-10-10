//
//  MoviesUseCaseMockup.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift

final class MoviesUseCaseMockup: MoviesUseCaseProtocol {
    func getTopRatedMovies(using filter: MoviesFilter) -> RxSwift.Single<MoviesResponse> {
        .just(MoviesResponse())
    }

    func getSimilarMovies() -> RxSwift.Single<MoviesResponse> {
        .just(MoviesResponse())
    }

    func getMovieDetail(_ movieID: String) -> Single<Movie> {
        .just(Movie())
    }
}
