//
//  ChartViewModel.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation

class ChartViewModel {
    
    var inputID: Observable<String?> = Observable(nil)
    var resultData: Observable<[Market]?> = Observable(nil)
    
    init() {
        inputID.bind { id in
            guard let id else { return }
            self.fetchData(id: id)
        }
    }
    
    func fetchData(id: String) {
        CoinAPIManager.shared.request(type: [Market].self, api: .Market(ids: id)) { data in
            self.resultData.value = data
        }
    }
    
}
