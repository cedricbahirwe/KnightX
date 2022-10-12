//
//  GetMoviesUseCasesTest.swift
//  TheMovieAppTests
//
//  Created by Cédric Bahirwe on 12/10/2022.
//

import XCTest
import RxTest
import RxSwift
@testable import TheMovieApp

class GetMoviesUseCasesTest: XCTestCase {
    var disposeBag: DisposeBag?
    var getMoviesUseCase: GetMoviesUseCaseProtocol?

    override func setUp() {
        disposeBag = DisposeBag()
        loadGetNewsUseCase()
    }

    override func tearDown() {
        disposeBag = nil
        getMoviesUseCase = nil
    }

    func testTopRatedMovies() {
        let id = 238
        let title = "The Godfather"
        let posterPath = "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
        let releaseDate = "1972-03-14"
        let popularity = 94.575

        getMoviesUseCase?.getTopRatedMovies(1)
            .subscribe(onSuccess: { movies in
                if let singleMovie = movies.0.first {
                    XCTAssertEqual(singleMovie.id, id)
                    XCTAssertEqual(singleMovie.title, title)
                    XCTAssertEqual(singleMovie.posterPath, posterPath)
                    XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                    XCTAssertEqual(singleMovie.popularity, popularity)
                }
            }, onFailure: { error in
                XCTFail("Error in top rated movies: \(error)")
            })
            .disposed(by: disposeBag!)
    }

    func testSimilarMovies() {
        let id = 80389
        let title = "Get the Gringo"
        let posterPath = "/sLzL1xG6JgVEEQ4DqSJpnJw3D2A.jpg"
        let releaseDate = "2012-03-15"
        let popularity = 94.575

        getMoviesUseCase?.getSimilarMovies(id)
            .subscribe(onSuccess: { movies in
                if let singleMovie = movies.0.first {
                    XCTAssertEqual(singleMovie.id, id)
                    XCTAssertEqual(singleMovie.title, title)
                    XCTAssertEqual(singleMovie.posterPath, posterPath)
                    XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                    XCTAssertNotEqual(singleMovie.popularity, popularity)
                }
            }, onFailure: { error in
                XCTFail("Error in similar movies: \(error)")
            })
            .disposed(by: disposeBag!)
    }

    func testSingleMovie() {
        let id = 70074
        let title = "The Godfather"
        let posterPath = "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
        let releaseDate = "1972-03-14"
        let popularity = 94.575

        getMoviesUseCase?.getMovieDetail(id)
            .subscribe(onSuccess: { singleMovie in
                XCTAssertEqual(singleMovie.id, id)
                XCTAssertEqual(singleMovie.title, title)
                XCTAssertEqual(singleMovie.posterPath, posterPath)
                XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                XCTAssertEqual(singleMovie.popularity, popularity)
            }, onFailure: { error in
                XCTFail("Error in single movie: \(error)")
            })
            .disposed(by: disposeBag!)
    }

    private func loadGetNewsUseCase() {
        getMoviesUseCase = GetMoviesUseCaseMockup()
    }
}
