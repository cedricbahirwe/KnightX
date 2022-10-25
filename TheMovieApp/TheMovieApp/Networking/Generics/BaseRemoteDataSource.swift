//
//  BaseRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift
import Combine
import Alamofire

class BaseRemoteDataSource {
    private let api: APIClient
    init() {
        api = APIClient()
    }

    func apiRequest<T: Codable>(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false) -> Single<(T, HTTPURLResponse)> {
        return api.request(urlRequest).catch({ [unowned self] error in
            if let movieError = getInternalError(error) {
                switch movieError {
                case .unauthorized:
                    return Single.error(movieError)
                default:
                    return Single.error(error)
                }
            } else {
                return Single.create(subscribe: { [unowned self] single -> Disposable in
                    if let pmError = parseError(error) {
                        single(.failure(pmError))
                    } else {
                        single(.failure(error))
                    }
                    return Disposables.create()
                })
            }
        })
    }

    func apiRequest(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false) -> Single<HTTPURLResponse> {
        return api.request(urlRequest).catch({ [unowned self] error in

            if let movieError = getInternalError(error) {
                switch movieError {
                case .unauthorized:
                    return Single.error(movieError)
                default:
                    return Single.error(error)
                }

            } else {
                return singleError(error: error)
            }
        })
    }

    func apiRequest<T: Decodable>(_ route: APIEndpoints) -> AnyPublisher<T, NetworkError> {
        api.request(route: route)
    }

    private func parseError(_ error: Error) -> APIError? {
        return getInternalError(error)
    }

    private func getInternalError(_ error: Error) -> APIError? {
        if case let APIError.apiError(code, _) = error {
            if code == 406 || code == 401 {
                return .unauthorized
            } else if code == 403 {
                return APIError.dataBaseError
            }
        }
        return nil
    }

    private func singleError(error: Error) -> Single<HTTPURLResponse> {
        return Single.create(subscribe: { [unowned self] single -> Disposable in
            if let sbError = parseError(error) {
                single(.failure(sbError))
            } else {
                single(.failure(error))
            }
            return Disposables.create()
        })
    }
}

extension Publisher {
  func tryDecodeResponse<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Publishers.TryMap<Self, Data>, Item, Coder> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == (data: Data, response: URLResponse) {
    return self
      .tryMap { output in
        guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return output.data
      }
      .decode(type: type, decoder: decoder)
  }
}
