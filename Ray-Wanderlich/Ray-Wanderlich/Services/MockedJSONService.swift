//
//  MockedJSONService.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/14/22.
//

import Combine

struct MockedJSONService<T: Mocked>: Service {
    typealias Data = T
    
    func fetch() -> AnyPublisher<T, Never> {
        T.mock
    }
}
