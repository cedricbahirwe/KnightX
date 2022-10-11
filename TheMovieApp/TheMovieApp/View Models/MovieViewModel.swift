//
//  MovieViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import Foundation

final class MovieViewModel: BaseViewModel, ObservableObject {
    @Published var movie: Movie
    @Published var similarMovies: [Movie]
    @Published var loadingState: LoadingState
    @Published var alert: AlertItem?
    private var currentPage: Int
    private let moviesUseCase: MoviesUseCaseProtocol


    init(_ movie: Movie,
         _ similarMovies: [Movie] = [],
         _ loadingState: LoadingState = .none,
         _ alert: AlertItem? = nil,
         _ moviesUseCase: MoviesUseCaseProtocol = MoviesUseCase()) {
        self.movie = movie
        self.similarMovies = similarMovies
        self.loadingState = loadingState
        self.alert = alert
        self.moviesUseCase = moviesUseCase
        self.currentPage = 1
        super.init()
        subscribeToErrors()
    }

    func subscribeToErrors() {
        errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            if case let APIError.retryError(message, retryAction) = error {
                self.alert = AlertItem(message: message, action: retryAction)
            } else if let error = error as? APIError {
                self.alert = AlertItem(message: error.message)
            } else {
                self.alert = AlertItem(message: error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }

    public func fetchMovie() {
        if loadingState == .none {
            self.loadingState = .wide
            moviesUseCase.getMovieDetail(movie.id)
                .subscribe(onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    self.movie = response
                    self.loadingState = .none
                    self.fetchSimilarMovies()
                }, onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self.loadingState = .none
                    self.handleError(error, self.fetchMovie)
                })
                .disposed(by: disposeBag)
        }
    }

    public func fetchSimilarMovies() {
        guard loadingState == .none else { return }
        self.loadingState = .medium
        moviesUseCase.getSimilarMovies(movie.id)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.similarMovies += response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.loadingState = .none
                self.handleError(error, self.fetchSimilarMovies)
            })
            .disposed(by: disposeBag)
    }

    public func clearSimilarMovies() {
        similarMovies = []
    }

    enum LoadingState {
        case wide
        case medium
        case small
        case none
    }
}
