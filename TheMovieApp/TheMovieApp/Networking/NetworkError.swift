//
//  NetworkError.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

typealias APIError = NetworkError
public enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unableToDecodeData
    case unableToEncodeData
    case unknownError(message: String)
    case apiError(code: Int, message: String)
    case serverError
    case internetConnection
    case timeout

    public var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .invalidResponse:
            return "The response found is not valid"
        case .unableToDecodeData:
            return "We could not process the result."
        case .unableToEncodeData:
            return "Unable to encode the entered data."
        case .unknownError(let message):
            return message
        case .serverError:
            return "There is an error on the server."
        case .internetConnection, .timeout:
            return "Check your internet connection and try again."
        case .invalidData:
            return "Unknown error encountered."
        case .apiError(_, let message):
            return message
        }
    }
}
