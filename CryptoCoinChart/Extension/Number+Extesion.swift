//
//  Number+Extesion.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/04.
//

import Foundation

extension Double {
    private static var wonFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    private static var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1
        return formatter
    }()
    
    func formattedWon() -> String {
        guard let formattedNumber = Double.wonFormatter.string(from: self as NSNumber) else { return "" }
        return "₩" + formattedNumber
    }
    
    func formattedPercent() -> String {
        let formattedString = Double.percentFormatter.string(from: self as NSNumber) ?? ""
        return self > 0 ? "+" + formattedString : formattedString
    }
    
    func isPositive() -> Bool {
        if self >= 0 {
            return true
        } else {
            return false
        }
    }
}

