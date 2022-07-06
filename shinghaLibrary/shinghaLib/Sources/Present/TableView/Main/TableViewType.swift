//
//  TableViewType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation

enum TableViewType: String, CaseIterable {
    case dataSourceToCell
    case rxSwiftToCell
    case dataSourceToSection
    case rxDataSourceToSection
    
    var title: String {
        switch self {
        case .dataSourceToCell:
            return "DataSources To Cell"
        case .rxSwiftToCell:
            return "RxSwift To Cell"
        case .dataSourceToSection:
            return "DataSources To Section"
        case .rxDataSourceToSection:
            return "RxDataSources To Section"
        }
    }
}
