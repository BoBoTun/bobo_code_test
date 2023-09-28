//
//  HomeViewModel.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
import Combine

final class HomeViewModel : BaseViewModel {

    let booksResultPublisher = CurrentValueSubject<[Book]?,Never>(nil)
    let model = BookModel.shared
    let nodataFound = PassthroughSubject<Bool,Never>()
    
    deinit{
        
    }
}

extension HomeViewModel {
    
    func getBooks(searchKeyword: String) {
        
        loadingPublishSubject.send(true)
        model.getBooks(searchKey: searchKeyword).sink { [unowned self] in
            loadingPublishSubject.send(false)
            guard case .failure(let error) = $0 else {return}
            errorPublishSubject.send(error)
        } receiveValue: { [unowned self] response in
            if let books = response?.books {
                booksResultPublisher.send(books)
            }else{
                nodataFound.send(true)
            }
            
            loadingPublishSubject.send(false)
        }.store(in: &bindings)

        
    }
}
