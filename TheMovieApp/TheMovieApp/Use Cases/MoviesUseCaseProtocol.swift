//
//  MoviesUseCaseProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

protocol MoviesUseCaseProtocol {
    func getTopRatedMovies() -> Single<([Movie], APIMetadata)>

    func getSimilarMovies() -> Single<([Movie], APIMetadata)>

    func getMovieDetail(_ movieID: String) -> Single<Movie>
}
