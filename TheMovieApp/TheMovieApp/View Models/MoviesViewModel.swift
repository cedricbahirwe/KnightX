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
    @Published var isLoadingMovies: Bool
    private var currentPage: Int

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        self.movies = []
        self.isLoadingMovies = false
        self.currentPage = 1
    }

    @MainActor
    public func getTopRatedMovies() async {
        guard !isLoadingMovies else { return }
        self.isLoadingMovies = true
        moviesUseCase.getTopRatedMovies(currentPage)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                
                if self.currentPage == 1 {
                    self.movies = response.0
                } else {
                    self.movies.append(contentsOf: response.0)
                }
                self.currentPage = response.1.currentPage + 1
                self.isLoadingMovies = false
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.isLoadingMovies = false
                self.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }

    public func loadNextPage(_ movie: Movie) async {
        guard movies.last?.id == movie.id else { return }
        await getTopRatedMovies()
    }

    public func hasReachedEnd(_ movie: Movie) async {
        guard movies.last?.id == movie.id else { return }
        await getTopRatedMovies()
    }

    public func refreshTopRatedMovies() async {
        guard !isLoadingMovies && currentPage != 1 else {  return }
        await getTopRatedMovies()
    }
}
