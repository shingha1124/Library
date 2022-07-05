//
//  TableViewType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation

enum TableViewType: String, CaseIterable {
    case cellWithDataSource
    case cellWithRxSwift
    case sectionWithDataSource
    
    var title: String {
        switch self {
        case .cellWithDataSource:
            return "Cell With DataSources"
        case .cellWithRxSwift:
            return "Cell With RxSwift"
        case .sectionWithDataSource:
            return "Section With DataSources"
        }
    }
}
