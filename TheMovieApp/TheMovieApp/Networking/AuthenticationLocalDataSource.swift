//
//  AuthenticationLocalDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

enum AuthenticationLocalDataSource {
    static func getAccessToken() -> String? {
        // Hard Coding the token, this could stored replaced 
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDhhMzY0ZmNlNGU1MjY4YWM1MzI3NDJjYzk0OWEwOCIsInN1YiI6IjYzNDUzNDQzNmEzMDBiMDA3YTI0ZTk2ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3YwZPKFFkhoPSjg9CujYZrkic523XCpOZ0mpUnjVPtk"
    }
}
