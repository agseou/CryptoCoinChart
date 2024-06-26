//
//  FavoriteViewModel.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/03.
//

import Foundation

class FavoriteViewModel {
    
    let repository = RealmRepository()
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var favoriteList: Observable<[Favorite]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            let data = self.repository.fetchItem(ofType: Favorite.self)
            self.favoriteList.value = Array(data)
        }
    }
    
}
