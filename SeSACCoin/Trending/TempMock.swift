//
//  TempMock.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import Foundation

enum TempMock {
    static let dataSource: [TrendingSection] = [
        .favorite(
            [
                .init(image: .btnStar, name: "1234", symbol: "1234", current_price: "1234", price_change_percentage: "3%"),
                .init(image: .btnStar, name: "1234", symbol: "1234", current_price: "1234", price_change_percentage: "3%"),
                .init(image: .btnStar, name: "1234", symbol: "1234", current_price: "1234", price_change_percentage: "3%"),
                .init(image: .btnStar, name: "1234", symbol: "1234", current_price: "1234", price_change_percentage: "3%")
            ]
        ),
        .topRank(
            [
                .init(rank: 1, image: .btnStar, name: "1234", symbol: "1234", price: "1234", price_change_percentage: "3%"),
                .init(rank: 2, image: .btnStar, name: "1234", symbol: "1234", price: "1234", price_change_percentage: "3%"),
                .init(rank: 3, image: .btnStar, name: "1234", symbol: "1234", price: "1234", price_change_percentage: "3%"),
                .init(rank: 4, image: .btnStar, name: "1234", symbol: "1234", price: "1234", price_change_percentage: "3%"),
                .init(rank: 5, image: .btnStar, name: "1234", symbol: "1234", price: "1234", price_change_percentage: "3%")
            ]
        )
    ]
}
