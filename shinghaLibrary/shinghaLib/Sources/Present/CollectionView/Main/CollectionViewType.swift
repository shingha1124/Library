//
//  CollectionViewType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import Foundation

enum CollectionViewType: String, CaseIterable {
    case flowLayout
    
    var title: String {
        switch self {
        case .flowLayout:
            return "FlowLayout"
        }
    }
}
