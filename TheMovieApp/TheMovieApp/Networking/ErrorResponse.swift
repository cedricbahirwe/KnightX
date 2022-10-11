//
//  ErrorResponse.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: Int?
    public let message: String?

    public enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}
