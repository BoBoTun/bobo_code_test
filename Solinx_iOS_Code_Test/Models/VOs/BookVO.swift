//
//  UserVo.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
// MARK: - BookVO
struct BookVO: Codable {
    let status: String?
    let books: [Book]?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case books = "books"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        books = try values.decodeIfPresent([Book].self, forKey: .books)
        
    }
}
