//
//  Search.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation

struct Search: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
}
