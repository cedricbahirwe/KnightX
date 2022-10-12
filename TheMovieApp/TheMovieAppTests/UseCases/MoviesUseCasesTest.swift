//
//  MoviesUseCasesTest.swift
//  TheMovieAppTests
//
//  Created by Cédric Bahirwe on 12/10/2022.
//

import Foundation
import RxSwift

class MoviesUseCasesTest: XCTestCase {
    var disposeBag: DisposeBag?
    var getNewsUseCase: GetNewsUseCase?

    override func setUp() {
        disposeBag = DisposeBag()

    }

    override func tearDown() {
        disposeBag = nil
        getNewsUseCase = nil
    }
}
