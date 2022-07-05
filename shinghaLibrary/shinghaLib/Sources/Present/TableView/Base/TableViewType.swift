//
//  TableViewType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation

enum TableViewType: String, CaseIterable {
    case baseTableView
    case rxTableView
    
    var title: String {
        self.rawValue
    }
}
