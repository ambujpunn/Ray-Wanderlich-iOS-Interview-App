//
//  JsonLoading.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/10/22.
//

import Foundation
import Combine

extension String: Error {}

// Using enum to take advantage of no default initializater
enum JSONLoader<T: Decodable>: String {
    
    enum JSONLoadingError: Error {
        case fileDoesntExist
        case decodingError(Error)
    }
    
    case articles
    case videos
    
    func load() -> AnyPublisher<T, Never> {
        return Future { promise in
            guard let url = Bundle.main.url(forResource: rawValue, withExtension: "json") else { preconditionFailure("JSON Loading: \(JSONLoadingError.fileDoesntExist): \(rawValue).json") }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return promise(.success(try decoder.decode(T.self, from: data)))
            } catch {
                preconditionFailure("JSON Loading: \(JSONLoadingError.decodingError(error)): \(rawValue).json, \(T.self)")
                
            }
       }.eraseToAnyPublisher()
    }
}
