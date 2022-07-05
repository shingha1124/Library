//
//  TableViewType.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation

enum TableViewType: String, CaseIterable {
    case withDataSource
    case withRxSwift
    
    var title: String {
        switch self {
        case .withDataSource:
            return "With DataSources"
        case .withRxSwift:
            return "With RxSwift"
        }
    }
}
