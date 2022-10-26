//
//  APIEndpoint.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation
import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }

    func asURLRequest() throws -> URLRequest
}

public enum APIEndpoint: APIConfiguration {

    case topRated(_ params: [String: Any])
    case similarMovies(_ movieID: Int)
    case movieDetail(_ movieID: Int)

    // MARK: - HTTPMethod
    public var method: HTTPMethod {
        switch self {
        case .topRated, .similarMovies, .movieDetail:
            return .get
        }
    }

    // MARK: - BaseURL
    public var baseURL: String {
        return "https://api.themoviedb.org/3"
    }

    // MARK: - Path
    public var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated"
        case .similarMovies(let id):
            return "/movie/\(id)/similar"
        case .movieDetail(let id):
            return "/movie/\(id)"
        }
    }

    // MARK: - Parameters
    public var parameters: Parameters? {
        switch self {
        case .topRated, .movieDetail, .similarMovies:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + path
        let url = try urlWithPathValue.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let accessToken = AuthenticationLocalDataSource.getAccessToken() {
            urlRequest.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            print("🏀 accessToken \(accessToken)")
        }

        if let parameters = parameters {
            switch self {
            case .similarMovies, .movieDetail:
                return urlRequest
            case .topRated:
                var urlComponents = URLComponents(string: urlWithPathValue)!
                urlComponents.queryItems = []

                _ = parameters.map { (key, value) in
                    let item = URLQueryItem(name: key, value: value as? String)
                    urlComponents.queryItems?.append(item)
                }

                guard let url = urlComponents.url else { fatalError("URL not found.") }
                urlRequest.url = url
            }
        }

        return urlRequest
    }
}
