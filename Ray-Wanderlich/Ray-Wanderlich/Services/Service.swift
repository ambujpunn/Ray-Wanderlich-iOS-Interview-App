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

