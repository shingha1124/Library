//
//  Int+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import Foundation

extension Int {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let stringPrice = formatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        return stringPrice
    }
    
    //MARK: int -> 원 표시
    func convertToKRW() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "ko_KR")
        return numberFormatter.string(for: self)
    }
}

extension Int {
}
