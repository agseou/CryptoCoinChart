//
//  APIManager.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import Foundation
import Alamofire

class CoinAPIManager {
    
    static let shared = CoinAPIManager()
    
    private init() { }
    
    @available(iOS 15.0, *)
    func request<T: Decodable>(type: T.Type,
                               api: CoinAPI) async throws -> T {
    
        return try await AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
                .serializingDecodable(T.self)
                .value
        }
}
