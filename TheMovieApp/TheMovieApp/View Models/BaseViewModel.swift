//
//  BaseViewModel.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Combine

class BaseViewModel {
    final var cancellables = Set<AnyCancellable>()
    let errorRelay = PassthroughSubject<Error, Never>()
    let loadingRelay = PassthroughSubject<Bool, Never>()

    func handleError(_ error: Error, _ retryAction: @escaping (() -> Void)) {
        errorRelay.send(parseApiErrorToRetry(error, retryAction))
    }

    private func parseApiErrorToRetry(_ error: Error, _ retryAction: @escaping (() -> Void)) -> Error {
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
}
