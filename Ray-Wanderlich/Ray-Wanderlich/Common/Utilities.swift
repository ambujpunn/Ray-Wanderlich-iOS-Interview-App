//
//  Utilities.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/10/22.
//

import Foundation

protocol Identifiable: Hashable {
    associatedtype RawIdentifier: Hashable = String
    
    var id: Identifier<Self> { get }
}

struct Identifier<T: Identifiable>: Hashable {
    let rawValue: T.RawIdentifier
}


