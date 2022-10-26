//
//  MoviesViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

final class MoviesViewModel: BaseViewModel, ObservableObject {
    @Published var topRatedMovies: [Movie]
    @Published var loadingState: LoadingState
    @Published var alert: AlertItem?

    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    private var currentPage: Int

    init(_ getMoviesUseCase: GetMoviesUseCaseProtocol) {
        self.getMoviesUseCase = getMoviesUseCase
        self.topRatedMovies = []
        self.loadingState = .none
        self.currentPage = 1
        super.init()
        subscribeToErrors()
        fetchTopRatedMovies()
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

    public func fetchTopRatedMovies() {
        guard loadingState == .none else { return }
        self.loadingState = .wide
        currentPage = 1
        getMoviesUseCase.getTopRatedMovies(currentPage)
            .sink(receiveCompletion: { [weak self] in
                if case .failure(let error) = $0 {
                    guard let self = self else { return }
                    self.loadingState = .none
                    self.handleError(error, self.fetchTopRatedMovies)
                }

            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.topRatedMovies = response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            })
            .store(in: &cancellables)
    }

    public func fetchNextTopRatedMovies() {
        guard loadingState == .none else { return }
        self.loadingState = .small
        getMoviesUseCase.getTopRatedMovies(currentPage)
            .sink(receiveCompletion: { [weak self] in
                if case .failure(let error) = $0 {
                    guard let self = self else { return }
                    self.loadingState = .none
                    self.handleError(error, self.fetchNextTopRatedMovies)
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.topRatedMovies += response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            })
            .store(in: &cancellables)
    }

    public func hasReachedEnd(_ movie: Movie) -> Bool {
        topRatedMovies.last?.id == movie.id && loadingState == .none
    }

    public func refreshTopRatedMovies() {
        fetchTopRatedMovies()
    }

    enum LoadingState {
        case wide
        case medium
        case small
        case none
    }
}
