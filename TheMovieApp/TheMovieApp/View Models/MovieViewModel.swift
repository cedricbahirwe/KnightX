//
//  MovieViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import Foundation
import Combine

final class MovieViewModel: BaseViewModel, ObservableObject {
    @Published var movie: Movie
    @Published var similarMovies: [Movie]
    @Published var loadingState: LoadingState
    @Published var alert: AlertItem?
    private var currentPage: Int
    private let getMoviesUseCase: GetMoviesUseCaseProtocol

    init(_ movie: Movie,
         _ similarMovies: [Movie] = [],
         _ loadingState: LoadingState = .none,
         _ alert: AlertItem? = nil,
         _ moviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase()) {
        self.movie = movie
        self.similarMovies = similarMovies
        self.loadingState = loadingState
        self.alert = alert
        self.getMoviesUseCase = moviesUseCase
        self.currentPage = 1
        super.init()
        subscribeToErrors()
    }

    func subscribeToErrors() {
        errorRelay.sink { [weak self] error in
            guard let self = self else { return }
            if case let APIError.retryError(message, retryAction) = error {
                self.alert = AlertItem(message: message, action: retryAction)
            } else if let error = error as? APIError {
                self.alert = AlertItem(message: error.message)
            } else {
                self.alert = AlertItem(message: error.localizedDescription)
            }
        }
        .store(in: &cancellables)
    }

    public func fetchMovie() {
        if loadingState == .none {
            self.loadingState = .wide
            getMoviesUseCase.getMovieDetail(movie.id)
                .sink(receiveCompletion: { [weak self] in
                    if case .failure(let error) = $0 {
                        guard let self = self else { return }
                        self.loadingState = .none
                        self.handleError(error, self.fetchMovie)
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.movie = response
                    self.loadingState = .none
                    self.fetchSimilarMovies()
                })
                .store(in: &cancellables)
        }
    }

    public func fetchSimilarMovies() {
        guard loadingState == .none else { return }
        self.loadingState = .medium
        getMoviesUseCase.getSimilarMovies(movie.id)
            .sink(receiveCompletion: { [weak self] in
                if case .failure(let error) = $0 {
                    guard let self = self else { return }
                    self.loadingState = .none
                    self.handleError(error, self.fetchSimilarMovies)
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.similarMovies += response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            })
            .store(in: &cancellables)
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
