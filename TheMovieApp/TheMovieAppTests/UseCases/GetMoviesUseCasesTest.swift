//
//  GetMoviesUseCasesTest.swift
//  TheMovieAppTests
//
//  Created by Cédric Bahirwe on 12/10/2022.
//

import XCTest
import Combine
@testable import TheMovieApp

class GetMoviesUseCasesTest: XCTestCase {
    var getMoviesUseCase: GetMoviesUseCaseProtocol?
    private var cancellables: Set<AnyCancellable>?
    
    override func setUp() {
        cancellables = Set<AnyCancellable>()
        loadGetNewsUseCase()
    }
    
    override func tearDown() {
        cancellables = nil
        getMoviesUseCase = nil
    }
    
    func testTopRatedMovies() {
        let id = 238
        let title = "The Godfather"
        let posterPath = "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
        let releaseDate = "1972-03-14"
        let popularity = 94.575
        
        getMoviesUseCase?.getTopRatedMovies(1)
            .sink(receiveCompletion: {
                if case .failure(let error) = $0 {
                    XCTFail("Error in top rated movies: \(error)")
                }
            }, receiveValue: { movies in
                if let singleMovie = movies.0.first {
                    XCTAssertEqual(singleMovie.id, id)
                    XCTAssertEqual(singleMovie.title, title)
                    XCTAssertEqual(singleMovie.posterPath, posterPath)
                    XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                    XCTAssertEqual(singleMovie.popularity, popularity)
                }
            })
            .store(in: &cancellables!)
    }
    
    func testSimilarMovies() {
        let id = 80389
        let title = "Get the Gringo"
        let posterPath = "/sLzL1xG6JgVEEQ4DqSJpnJw3D2A.jpg"
        let releaseDate = "2012-03-15"
        let popularity = 94.575
        
        getMoviesUseCase?.getSimilarMovies(id)
            .sink(receiveCompletion: {
                if case .failure(let error) = $0 {
                    XCTFail("Error in similar movies: \(error)")
                }
            }, receiveValue: { movies in
                if let singleMovie = movies.0.first {
                    XCTAssertEqual(singleMovie.id, id)
                    XCTAssertEqual(singleMovie.title, title)
                    XCTAssertEqual(singleMovie.posterPath, posterPath)
                    XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                    XCTAssertNotEqual(singleMovie.popularity, popularity)
                }
            })
            .store(in: &cancellables!)
    }
    
    func testSingleMovie() {
        let id = 70074
        let title = "The Godfather"
        let posterPath = "/arJfxShfuZPhqfBZZU6DkPZfnjn.jpg"
        let releaseDate = "2013-01-31"
        let popularity = 94.575
        
        getMoviesUseCase?.getMovieDetail(id)
            .sink(receiveCompletion: {
                if case .failure(let error) = $0 {
                    XCTFail("Error in single movie: \(error)")
                }
            }, receiveValue: { singleMovie in
                XCTAssertEqual(singleMovie.id, id)
                XCTAssertEqual(singleMovie.posterPath, posterPath)
                XCTAssertEqual(singleMovie.releaseDate, releaseDate)
                XCTAssertEqual(singleMovie.genres?.count, 3)
                XCTAssertNotEqual(singleMovie.title, title)
                XCTAssertNotEqual(singleMovie.popularity, popularity)
            })
            .store(in: &cancellables!)
    }
    
    private func loadGetNewsUseCase() {
        getMoviesUseCase = GetMoviesUseCaseMockup()
    }
}
