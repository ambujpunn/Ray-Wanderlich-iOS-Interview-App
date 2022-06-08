//
//  Content.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/7/22.
//

import Foundation
import Combine

protocol Identifiable {
    associatedtype RawIdentifier: Decodable = String
    
    var id: Identifier<Self> { get }
}

struct Identifier<T: Identifiable>: Decodable {
    let rawValue: T.RawIdentifier
}

enum ContentType: String, Decodable {
    case article, video
    
    enum CodingKeys: String, CodingKey {
        case article, video = "collections"
    }
}

extension ContentType: Identifiable {
    var id: Identifier<ContentType> {
        Identifier(rawValue: rawValue)
    }
}

//protocol Content {
protocol Content: Identifiable {
    var name: String { get }
    var description: String { get }
    var releaseDate: Date { get }
    var imageURL: URL { get }
    var type: ContentType { get }
    var contentURL: URL { get }
    // Note: Need to include body somehow - because it is another API pull - but only needed when seeing more info about the article
    //var body: AnyPublisher { get }
}


struct Article: Content {
    let name: String
    let description: String
    let releaseDate: Date
    let imageURL: URL
    let type: ContentType
    let id: Identifier<Article>
    let contentURL: URL
}

extension Article: Decodable {
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
        contentURL = try linksContainer.decode(URL.self, forKey: .url)
    }
}

struct ArticleResults {
    let articles: [Article]
}
extension ArticleResults: Decodable {}
