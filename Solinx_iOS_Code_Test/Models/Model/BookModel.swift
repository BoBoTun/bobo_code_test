//
//  BookModel.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
import Combine

struct BookModel {
    static let shared = BookModel()
}

extension BookModel {
    func getBooks(searchKey: String) -> AnyPublisher<BookVO?,APIError>{
        
        let url = APIConfig.GetBooks.getBooks.urlStringWithSearchKey(searchKey: searchKey)
        
        return APIService.shared.requestCombine(url: url, method: .get).compactMap { data -> BookVO? in
            
            
            if let response = data.decode(modelType: BookVO.self){
                
                return response
            }
            return nil
        }.eraseToAnyPublisher()
    }
}
