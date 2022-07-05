//
//  ExampleTableCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation

struct TableModel {
    let title: String
}

struct SampleDataModel {
    let name: String
    let cellModels: [TableModel]
}

struct SectionTableModel {
    let name: String
    let cellModels: [TableViewCellModel]
}
