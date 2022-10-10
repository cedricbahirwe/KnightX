//
//  MoviesViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

final class MoviesViewModel: BaseViewModel, ObservableObject {
    private let moviesUseCase: MoviesUseCaseProtocol
    @Published
    private(set) var movies: [Movie] = []
    @Published var filter = MoviesFilter()

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
    }

    public func getTopRatedMovies() {
        filter.limit = 50
        moviesUseCase.getTopRatedMovies(using: filter)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    print("Sucess", response)
                }
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
