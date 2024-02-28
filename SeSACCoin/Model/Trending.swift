//
//  Trending.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import Foundation

struct Trending: Decodable {
    let coins: [items] // COIN
    let nfts: [Nft] // NFT
}


// MARK: - COIN
struct items: Decodable {
    let item: [Item]
}

struct Item: Decodable {
    let id: String // 코인 ID
    let name: String // 코인 이름
    let symbol: String // 코인 통화 단위
    let market_cap_rank: Int
    let thumb, small, large: String
    let slug: String
    let data: ItemData
}

struct ItemData: Decodable {
    let price: String
    let price_change_percentage_24h: PriceChangePercentage24H
}

struct PriceChangePercentage24H: Decodable {
    let krw: Double
}

// MARK: - NFT
struct Nft: Decodable {
    let name: String // NFT 이름
    let symbol: String // NFT 통화 단위
    let thumb: String // NFT 아이콘 리소스
    let data: NftData
}

struct NftData: Decodable {
    let floor_price: String // NFT 최저가
    let floor_price_in_usd_24h_percentage_change: String // NFT 변동포
}
