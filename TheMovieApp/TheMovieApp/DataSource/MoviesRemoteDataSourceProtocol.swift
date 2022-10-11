//
//  MoviesRemoteDataSourceProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import RxSwift

protocol MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies() -> Single<([Movie], APIMetadata)>

    func getSimilarMovies() -> Single<([Movie], APIMetadata)>

    func getMovieDetail(_ movieID: String) -> Single<Movie>
}
