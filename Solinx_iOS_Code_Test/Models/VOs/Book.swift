//
//  Book.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
// MARK: - Book
struct Book: Codable {
    let id, title, subtitle, authors: String?
    let image: String?
    let url: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case subtitle = "subtitle"
        case authors = "authors"
        case image = "image"
        case url = "url"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
        authors = try values.decodeIfPresent(String.self, forKey: .authors)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        
    }
}
