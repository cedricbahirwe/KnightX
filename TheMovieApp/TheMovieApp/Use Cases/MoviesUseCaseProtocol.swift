//
//  MoviesUseCaseProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

protocol MoviesUseCaseProtocol {
    func getTopRatedMovies(using filter: MoviesFilter) -> Single<MoviesResponse>
    func getSimilarMovies() -> Single<MoviesResponse>
    func getMovieDetail(_ movieID: String) -> Single<Movie>
}
