//
//  MoviesUseCaseProtocol.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift

protocol MoviesUseCaseProtocol {
    func getTopRatedMovies(_ page: Int) -> Single<([Movie], APIMetadata)>

    func getSimilarMovies(_ page: Int) -> Single<([Movie], APIMetadata)>

    func getMovieDetail(_ movieID: Int) -> Single<Movie>
}
