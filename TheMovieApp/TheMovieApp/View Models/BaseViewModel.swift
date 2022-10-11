//
//  BaseViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    let errorRelay = PublishRelay<Error>()
    let loadingRelay = PublishRelay<Bool>()

    func handleError(_ error: Error, _ retryAction: @escaping (() async -> Void)) {
        errorRelay.accept(parseApiErrorToRetry(error, retryAction))
    }

    private func parseApiErrorToRetry(_ error: Error, _ retryAction: @escaping (() async -> Void)) -> Error {
        switch error {
        case APIError.apiError(_, let message):
            return APIError.retryError(message: message, retryAction: retryAction)
        case APIError.internetConnection:
            return APIError.retryError(message: "No internet connection", retryAction: retryAction)
        case APIError.timeout:
            return APIError.retryError(message: "Error encountered", retryAction: retryAction)
        default:
            return error
        }
    }

    private func logout() {
        // Remove credentials
    }
}
