//
//  APIClient.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import Alamofire
import Combine

public class APIClient {
    private static var sessionManager: Session = Session()
#if DEBUG
    let log: Logger = Logger()
#endif

    static func request<T: Decodable>(route: APIEndpoint) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return sessionManager.request(route)
            .publishDecodable(type: T.self, decoder: decoder)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    func logError(_ urlRequest: URLRequest, response: HTTPURLResponse) {
        #if DEBUG
        log.error(urlRequest)
        log.error(urlRequest.allHTTPHeaderFields ?? [:])
        log.error(response)
        #endif
    }
}
