//
//  JSonLocalDataSource.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 11/10/2022.
//

import Foundation
import RxSwift
import Combine

class JsonLocalDataSource {
    func read<T: Decodable>(_ fileName: String) -> Single<T> {
        return Single.create(subscribe: { (observer) -> Disposable in
            if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    observer(.success(try decoder.decode(T.self, from: data)))
                } catch {
                    observer(.failure(error))
                }
            } else {
                observer(.failure(APIError.fileNotFound(fileName)))
            }
            return Disposables.create()
        })
    }

    func read<T: Decodable>(_ fileName: String) -> AnyPublisher<T, Error> {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(T.self, from: data)
                return CurrentValueSubject(result).eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        } else {
            return Fail(error: NSError(domain: APIError.fileNotFound(fileName).message,
                                       code: -10001)).eraseToAnyPublisher()
        }
    }
}
