//
//  Service.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/10/22.
//

import Foundation

protocol Service {
    associatedtype Data: Hashable
    
    func fetch() -> Data
}

struct MockedDataService {
    
}
