//
//  AlertItem.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import Foundation

struct AlertItem: Identifiable {
    var id: String { message }
    let title: String
    let message: String
    var action: (() async -> Void)?

    init(_ title: String = "Alert", message: String, action: (() async -> Void)? = nil) {
        self.title = title
        self.message = message
        self.action = action
    }
}
