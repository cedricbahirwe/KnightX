//
//  MoviesRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Combine

final class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        let params: [String: Any] = ["page": page]
        let publisher: AnyPublisher<MoviesDataResponse, Error> = apiRequest(.topRated(params))
        
        return publisher.map { ($0.movies, $0.metadata) }.eraseToAnyPublisher()
    }
    
    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), Error> {
        let publisher: AnyPublisher<MoviesDataResponse, Error> = apiRequest(.similarMovies(movieID))
        return publisher.map { ($0.movies, $0.metadata) }.eraseToAnyPublisher()
    }
    
    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, Error> {
        apiRequest(.movieDetail(movieID))
    }
}
