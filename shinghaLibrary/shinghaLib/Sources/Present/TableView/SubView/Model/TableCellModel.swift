//
//  ExampleTableCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxDataSources

struct SampleTableData {
    let title: String
}

struct SampleTableSectionData {
    let name: String
    let cellModels: [SampleTableData]
}

struct SectionTableModel {
    let name: String
    let items: [TableViewCellModel]
}
