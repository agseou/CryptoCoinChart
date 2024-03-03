//
//  TrendingViewModel.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/03.
//

import Foundation
import UIKit


class TrendingViewModel {
    
    let repository = RealmRepository()
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputsections:  Observable<[TrendingSection]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            self.fetchDataFromRealm()
        }
    }
    
    private func fetchDataFromRealm() {
        var sections: [TrendingSection] = []
        
        let favorites: [Favorite] = Array(repository.fetchItem(ofType: Favorite.self))
        
        if !favorites.isEmpty {
            sections.append(.favorites(favorites))
        }
        CoinAPIManager.shared.request(type: Trending.self, api: .Trending) { data in
            let coinTopRankItems = data.coins.map { $0.item }.sorted { $0.market_cap_rank < $1.market_cap_rank }
            if !coinTopRankItems.isEmpty {
                sections.append(.coinTopRank(coinTopRankItems))
            }
            
            // NFT 데이터 가공
            let nftTopRankItems: [Nft] = data.nfts
            if !nftTopRankItems.isEmpty {
                sections.append(.nftTopRank(nftTopRankItems))
            }
            
            // 메인 스레드에서 UI 업데이트
            DispatchQueue.main.async {
                self.outputsections.value = sections
            }
        }
    }
}
