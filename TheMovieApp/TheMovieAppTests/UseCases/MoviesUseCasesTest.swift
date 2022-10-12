//
//  MoviesUseCasesTest.swift
//  TheMovieAppTests
//
//  Created by Cédric Bahirwe on 12/10/2022.
//

import XCTest
//import RxSwift
import TheMovieApp

class MoviesUseCasesTest: XCTestCase {
//    var disposeBag: DisposeBag?
//    var getMoviesUseCase: GetMoviesUseCaseProtocol?

    override func setUp() {
//        disposeBag = DisposeBag()
    }

    override func tearDown() {
//        disposeBag = nil
//        getMoviesUseCase = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testTopRatedMovies() {
//        loadMoviesUseCase()
//        let movieID = 238
//        let title = "The Godfather"
//        let posterPath = "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
//        let releaseDate = "1972-03-14"
//        let popularity = 94.575
//
//
//        getMoviesUseCase.getTopRatedMovies(1).subscribe(onSuccess: { movies in
//            if let singeMovie = movies.first {
//                XCTAssertEqual(singeMovie.id, movieID)
//                XCTAssertEqual(singeMovie.title, title)
//                XCTAssertEqual(singleNews.posterPath, posterPath)
//                XCTAssertEqual(singleNews.releaseDate, releaseDate)
//                XCTAssertEqual(singleNews.popularity, popularity)
//            }
//        }, onFailure: { (error) in
//            XCTFail("Error in top rated movies: \(error)")
//        }).disposed(by: disposeBag!)
//    }


//    private func loadMoviesUseCase() {
//        getMoviesUseCase = GetMoviesUseCaseMockup()
//    }
}
