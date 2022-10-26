//
//  BaseRemoteDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Combine

class BaseRemoteDataSource {
    func apiRequest<T: Decodable>(_ route: APIEndpoint) -> AnyPublisher<T, Error> {
        APIClient.request(route: route)
    }
}
