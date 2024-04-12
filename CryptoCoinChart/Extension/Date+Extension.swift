//
//  Date+Extension.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/04.
//

import Foundation

extension String {
    func formattedDateString() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else { return "Invalid Date" }
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = "M/d HH:mm:ss"

        return customFormatter.string(from: date)
    }
}
