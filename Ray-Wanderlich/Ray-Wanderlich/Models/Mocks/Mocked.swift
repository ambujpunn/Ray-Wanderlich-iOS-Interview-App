//
//  Mocked.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/14/22.
//

import Combine

protocol Mocked: Hashable {
    static var mock: AnyPublisher<Self, Never> { get }
}
