//
//  MoviesViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

final class MoviesViewModel: BaseViewModel, ObservableObject {
    @Published var movies: [Movie]
    @Published var loadingState: LoadingState
    @Published var alert: AlertItem?

    private let moviesUseCase: MoviesUseCaseProtocol
    private var currentPage: Int

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        self.movies = []
        self.loadingState = .none
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

    @MainActor
    public func fetchTopRatedMovies() async {
        guard loadingState == .none else { return }
        self.loadingState = .wide
        currentPage = 1
        moviesUseCase.getTopRatedMovies(currentPage)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.movies = response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.loadingState = .none
                self.handleError(error, self.fetchTopRatedMovies)
            })
            .disposed(by: disposeBag)
    }


    @MainActor
    public func fetchNextTopRatedMovies() async {
        guard loadingState == .none else { return }
        self.loadingState = .small
        moviesUseCase.getTopRatedMovies(currentPage)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.movies += response.0
                self.currentPage = response.1.currentPage + 1
                self.loadingState = .none
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.loadingState = .none
                self.handleError(error, self.fetchNextTopRatedMovies)
            })
            .disposed(by: disposeBag)
    }

    public func hasReachedEnd(_ movie: Movie) -> Bool {
        movies.last?.id == movie.id && loadingState == .none
    }

    public func refreshTopRatedMovies() async {
        await fetchTopRatedMovies()
    }

    enum LoadingState {
        case wide
        case medium
        case small
        case none
    }
}
