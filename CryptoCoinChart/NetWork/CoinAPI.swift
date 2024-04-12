//
//  CoinAPI.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation
import Alamofire

enum CoinAPI {
    
    case Trending
    case Search(query: String)
    case Market(ids: String)
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endpoint: URL {
        switch self {
        case .Trending:
            return URL(string: baseURL + "search/trending")!
        case .Search:
            return URL(string: baseURL + "search")!
        case .Market:
            return URL(string: baseURL + "coins/markets")!
        }
    }
    
    var header: HTTPHeaders {
        return ["accept": "application/json"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .Trending:
            [:]
        case .Search(let query):
            ["query": query]
        case .Market(let ids):
            ["vs_currency": "krw",
             "ids": ids,
             "sparkline": "true",
             "locale": "ko"]
        }
    }
}
