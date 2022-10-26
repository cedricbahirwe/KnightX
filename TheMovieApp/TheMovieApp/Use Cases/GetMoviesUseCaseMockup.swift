//
//  MoviesUseCaseMockup.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift
import Combine

final class GetMoviesUseCaseMockup: GetMoviesUseCaseProtocol {
    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), APIError> {
        let data: AnyPublisher<MoviesDataResponse, Error> = jsonLocalDataSource.read("TopRatedMovies")
        return data
            .map { ($0.movies, $0.metadata) }
            .mapError { APIError.unknownError(message: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), APIError> {
        let data: AnyPublisher<MoviesDataResponse, Error> = jsonLocalDataSource.read("SimilarMovies")
        return data
            .map({ ($0.movies, $0.metadata) })
            .mapError({ APIError.unknownError(message: $0.localizedDescription) })
            .eraseToAnyPublisher()
    }

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, APIError> {
        let data: AnyPublisher<Movie, Error> = jsonLocalDataSource.read("SingleMovie")
        return data
            .mapError({ APIError.unknownError(message: $0.localizedDescription) })
            .eraseToAnyPublisher()
    }

    private let jsonLocalDataSource: JsonLocalDataSource

    public init() {
        jsonLocalDataSource = JsonLocalDataSource()
    }
    
    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)> {
        let data: Single<MoviesDataResponse> = jsonLocalDataSource.read("TopRatedMovies")
        return data.map({ ($0.movies, $0.metadata) })
    }

    func getSimilarMovies(_ movieID: Int) -> Single<([Movie], APIMetadata)> {
        let data: Single<MoviesDataResponse> = jsonLocalDataSource.read("SimilarMovies")
        return data.map({ ($0.movies, $0.metadata) })
    }

    func getMovieDetail(_ movieID: Int) -> Single<Movie> {
        return jsonLocalDataSource.read("SingleMovie")
    }
}
