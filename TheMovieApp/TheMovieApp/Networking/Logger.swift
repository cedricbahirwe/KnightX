//
//  Logger.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Foundation

open class Logger {
    /// The queue used for logging.
    private let queue = DispatchQueue(label: "themovie.alpha.log")

    func error(_ log: Any, terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        queue.async {
            Swift.print(log, function, file, line, column)
        }
    }
}
