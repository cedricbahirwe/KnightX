//
//  MoviesUseCaseMockup.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift

final class MoviesUseCaseMockup: MoviesUseCaseProtocol {
    private let jsonLocalDataSource: JsonLocalDataSource

    public init() {
        jsonLocalDataSource = JsonLocalDataSource()
    }

    func getTopRatedMovies() -> Single<([Movie], APIMetadata)> {
        let data: Single<MoviesDataResponse> = jsonLocalDataSource.read("TopRatedMovies")
        return data.map({ ($0.movies, $0.metadata) })
    }

    func getSimilarMovies() -> RxSwift.Single<([Movie], APIMetadata)> {
        let data: Single<MoviesDataResponse> = jsonLocalDataSource.read("SimlarMovies")
        return data.map({ ($0.movies, $0.metadata) })
    }

    func getMovieDetail(_ movieID: String) -> RxSwift.Single<Movie> {
        return jsonLocalDataSource.read("Movie")
    }
}
