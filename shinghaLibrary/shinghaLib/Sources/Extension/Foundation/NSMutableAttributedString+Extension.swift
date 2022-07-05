//
//  NSMutableAttributedString+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/09.
//

import Foundation

extension NSMutableAttributedString {
    func appendAttributedString(_ strings: [NSAttributedString]) -> NSMutableAttributedString {
        strings.forEach {
            self.append($0)
        }
        return self
    }
}
