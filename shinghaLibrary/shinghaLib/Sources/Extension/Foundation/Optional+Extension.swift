//
//  Optional+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/09.
//

import Foundation

protocol _CollectionOrStringish {
    var isEmpty: Bool { get }
}

extension Optional where Wrapped: _CollectionOrStringish {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(value): return value.isEmpty
        default: return true
        }
    }
}

extension String: _CollectionOrStringish { }
extension Array: _CollectionOrStringish { }
extension Dictionary: _CollectionOrStringish { }
extension Set: _CollectionOrStringish { }
