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
    
    func request<T: Decodable>(type: T.Type,
                               api: CoinAPI,
                               completionHandler: @escaping ((T) -> Void)) {
    
        AF.request(api.endpoint, 
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { respose in
            print(respose.response?.url)
            switch respose.result {
            case .success(let success):
                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}
