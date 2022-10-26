//
//  MoviesRemoteDataSourceProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import Combine

protocol MoviesRemoteDataSourceProtocol {

    func getTopRatedMovies(_ page: Int) -> AnyPublisher<([Movie], APIMetadata), Error>

    func getSimilarMovies(_ movieID: Int) -> AnyPublisher<([Movie], APIMetadata), Error>

    func getMovieDetail(_ movieID: Int) -> AnyPublisher<Movie, Error>
}
