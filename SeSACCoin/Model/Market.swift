//
//  Market.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation

struct Market: Decodable {
    let id: String // 코인 ID
    let symbol: String // 코인 통화 단위
    let name: String // 코인 이름
    let image: String // 코인 아이콘 리소스
    let current_price: Int // 코인 현재가 ( 싯가 )
    let market_cap: Int
    let market_cap_rank: Int
    let high_24h: Int // 코인 고가
    let low_24h: Int // 코인 저가
    let price_change_percentage_24h: Double // 코인 변동폭
    let ath: Int // 코인 사상 최고가 == 신고점
    let ath_date: String // 신고점 일자
    let atl: Int // 코인 사상 최저가 == 신저점
    let atl_date: String // 신저점 일자
    let last_updated: String // 마지막 업뎃일
    let sparkline_in_7d: SparklineIn7D
}

struct SparklineIn7D: Decodable {
    let price: [Double]
}
