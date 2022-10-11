//
//  MoviesViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

final class MoviesViewModel: BaseViewModel, ObservableObject {
    private let moviesUseCase: MoviesUseCaseProtocol
    @Published var movies: [Movie]

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        self.movies = []
    }

    public func getTopRatedMovies() {
        moviesUseCase.getTopRatedMovies()
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.movies = response.0
                }
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }

    public func refreshTopRatedMovies() async {

    }
}
