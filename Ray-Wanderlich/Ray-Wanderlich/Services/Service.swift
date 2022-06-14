//
//  Service.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/10/22.
//

import Foundation
import Combine

protocol Service {
    associatedtype Data: Hashable
    
    func fetch() -> AnyPublisher<Data, Never>
}

protocol Serviceable {
    func setService<S: Service>(_ service: S)
}

extension Serviceable {
    func setService<S: Service>(_ service: S) { assertionFailure("Service: \(S.self) attempting to be used but has not been set.") }
}
