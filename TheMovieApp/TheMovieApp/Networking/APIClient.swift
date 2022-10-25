//
//  APIClient.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import Combine

public class APIClient {
    private var sessionManager: Session
#if DEBUG
    let log: Logger = Logger()
#endif

    public init() {
        sessionManager = Session()
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (response, urlResponse) in
                    observer(.success((response, urlResponse)))
                }, { (error) in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(APIError.internetConnection))
                return Disposables.create()
            }
        })
    }

    func request(_ urlRequest: URLRequest) -> Single<(HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (urlResponse) in
                    observer(.success((urlResponse)))
                }, { (error) in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(APIError.internetConnection))
                return Disposables.create()
            }
        })
    }

    func request<T: Decodable>(route: APIEndpoints) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return sessionManager.request(route)
            .publishDecodable(type: T.self, decoder: decoder)
            .value()
            .mapError { APIError.apiError(code: $0.responseCode ?? -1, message: $0.errorDescription ?? $0.localizedDescription) }
            .eraseToAnyPublisher()
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: APIError) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                guard let httpUrlResponse = response.response else {
                    return
                }
                let statusCode = httpUrlResponse.statusCode
                if 200..<300 ~= statusCode {
                    self.decodeResponse(response, responseHandler)
                } else {
                    guard let data = response.data else { return }
                    self.decode(data, statusCode: statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func request(_ urlRequest: URLRequest,
                         _ responseHandler: @escaping (HTTPURLResponse) -> Void,
                         _ errorHandler: @escaping ((_ error: APIError) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseData()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (httpUrlResponse, data) in
                if 200..<300 ~= httpUrlResponse.statusCode {
                    responseHandler(httpUrlResponse)
                } else {
                    guard let self = self else { return }
                    self.logError(urlRequest, response: httpUrlResponse)
                    self.decode(data, statusCode: httpUrlResponse.statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func decode(_ data: Data, statusCode: Int, _ errorHandler: ((_ error: APIError) -> Void)) {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            errorHandler(APIError.apiError(code: errorResponse.code ?? statusCode,
                                           message: errorResponse.message ?? ""))
        } catch {
            errorHandler(.unableToDecodeData)
        }
    }

    private func decodeResponse<T: Decodable>(_ response: DataResponse<Any, AFError>,
                                              _ responseHandler: @escaping (T, HTTPURLResponse) -> Void) {
        if let jsonData = response.data, let httpUrlResponse = response.response {
            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                print("The Json is", jsonObject)
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                responseHandler(try decoder.decode(T.self, from: jsonData), httpUrlResponse)
            } catch let error {
                print("Decoding error: \(error), \(T.self)")
            }
        }
    }

    func logError(_ urlRequest: URLRequest, response: HTTPURLResponse) {
        #if DEBUG
        log.error(urlRequest)
        log.error(urlRequest.allHTTPHeaderFields ?? [:])
        log.error(response)
        #endif
    }
}
