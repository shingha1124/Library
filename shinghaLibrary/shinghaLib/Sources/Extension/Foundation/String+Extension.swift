//
//  UIString+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import UIKit

extension String {
    func hexToColor() -> UIColor {
        var hexString = ""
        if self.first == "#" {
            hexString = String(self.dropFirst())
        } else {
            hexString = self
        }
        
        if hexString.count == 6 {
            hexString += "ff"
        }
        
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            let a = CGFloat((hexNumber & 0x000000ff)) / 255
            return UIColor(red: r, green: g, blue: b, alpha: a)
        } else {
            return UIColor(red: 255, green: 0, blue: 255, alpha: 1)
        }
    }
    
    func localized(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        String(format: self.localized(comment: comment), argument)
    }
}
