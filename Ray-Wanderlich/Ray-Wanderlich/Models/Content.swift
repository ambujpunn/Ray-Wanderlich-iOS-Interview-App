//
//  Content.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/7/22.
//

import Foundation
import Combine

protocol Mocked {
    var mock: AnyPublisher<Self, Never> { get }
}

enum ContentType: String, Decodable {
    case article, video
    
    enum CodingKeys: String, CodingKey {
        case article, video = "collections"
    }
}

struct Content: Identifiable {
    let name: String
    let description: String
    let releaseDate: Date
    let imageURL: URL
    let type: ContentType
    let id: Identifier<Content>
    let bodyURL: URL
}

extension Content: Decodable {
    enum OuterKeys: CodingKey {
        case id, attributes, links
    }
    
    enum AttributesKeys: String, CodingKey {
        case name, description
        case releaseDate = "released_at", imageURL = "card_artwork_url", type = "content_type"
    }
    
    enum LinksKeys: String, CodingKey {
        case url = "self"
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let attributesContainer = try outerContainer.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        let linksContainer = try outerContainer.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)
        
        let idResult = try outerContainer.decode(String.self, forKey: .id)
        id = .init(rawValue: idResult)
        name = try attributesContainer.decode(String.self, forKey: .name)
        description = try attributesContainer.decode(String.self, forKey: .description)
        releaseDate = try attributesContainer.decode(Date.self, forKey: .releaseDate)
        imageURL = try attributesContainer.decode(URL.self, forKey: .imageURL)
        type = try attributesContainer.decode(ContentType.self, forKey: .type)
        bodyURL = try linksContainer.decode(URL.self, forKey: .url)
    }
}

extension Content: Mocked {
    var mock: AnyPublisher<Content, Never> {
        JSONLoader<Content>.articles.load()
    }
}

struct ContentResults {
    let contents: [Content]
}
extension ContentResults: Decodable {}


