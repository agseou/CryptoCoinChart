//
//  SearchViewModel.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation

class SearchViewModel {
    
    var inputSearchKeyword: Observable<String?> = Observable(nil)
    var searchList: Observable<[Coin]> = Observable([])
    
    init() {
        inputSearchKeyword.bind { value in
            guard let value else { return }
            self.fetchRequest(query: value)
        }
    }
    
    private func fetchRequest(query: String) {
        CoinAPIManager.shared.request(type: Search.self, api: .Search(query: query)) { value in
            self.searchList.value = value.coins
        }
    }
    
}
