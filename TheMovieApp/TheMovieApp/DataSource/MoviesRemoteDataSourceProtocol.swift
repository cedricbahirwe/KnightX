//
//  MoviesRemoteDataSourceProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import RxSwift

protocol MoviesRemoteDataSourceProtocol {
    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)>

    func getSimilarMovies(_ page: Int) -> Single<([Movie], APIMetadata)>

    func getMovieDetail(_ movieID: Int) -> Single<Movie>
}
