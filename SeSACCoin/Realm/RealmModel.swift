//
//  RealmModel.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/29.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinID: String // 코인 ID
    @Persisted var name: String // 코인 이름
    @Persisted var symbol: String // 코인 통화단위
    @Persisted var image: String // 코인 아이콘
    @Persisted var current_price: Double
    @Persisted var price_change_percentage: Double
    
    convenience init(
        coinID: String,
        name: String,
        symbol: String,
        image: String,
        current_price: Double,
        price_change_percentage: Double
    ) {
        self.init()
        self.coinID = coinID
        self.name = name
        self.symbol = symbol
        self.image = image
        self.current_price = current_price
        self.price_change_percentage = price_change_percentage
    }
}
