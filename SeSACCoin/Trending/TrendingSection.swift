//
//  TrendingSection.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

enum TrendingSection {
    struct trendFavorite {
        let image: UIImage
        let name: String
        let symbol: String
        let current_price: String
        let price_change_percentage: String
    }
    struct trendTopRank {
        let rank: Int
        let image: UIImage
        let name: String
        let symbol: String
        let price: String
        let price_change_percentage: String
    }
    
    case favorite([trendFavorite])
    case topRank([trendTopRank])
}
