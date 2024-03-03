//
//  NumberFormatterManager.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import Foundation

class NumberFormatterManager {
    
    static let shared = NumberFormatterManager()
    
    private init() { }
    
    private let numberFormatter = NumberFormatter()
    
    func calculator(_ number: Double) -> String {
        numberFormatter.numberStyle = .decimal
        let result = "₩" + numberFormatter.string(from: number as NSNumber)!
        return result 
    }
    
}
