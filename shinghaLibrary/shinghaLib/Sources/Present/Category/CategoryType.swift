//
//  MainItemType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/23.
//

import Foundation

enum CategoryType: String, CaseIterable {
    case tableView
    
    var title: String {
        self.rawValue
    }
}
