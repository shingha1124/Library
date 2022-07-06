//
//  MainItemType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/23.
//

import Foundation

enum CategoryType: String, CaseIterable {
    case tableView
    case collectionView
    
    var title: String {
        switch self {
        case .tableView:
            return "TableView"
        case .collectionView:
            return "CollectionView"
        }
    }
}
