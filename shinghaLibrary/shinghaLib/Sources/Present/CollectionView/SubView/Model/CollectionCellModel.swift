//
//  CollectionCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import Foundation

struct SampleCollectionData {
    let id: Int
    let hexColor: String
    
    init(id: Int) {
        self.id = id
        hexColor = (0..<3).map { _ in String(Int.random(in: 0..<255), radix: 16) }.joined()
    }
}

struct SampleCollectionSectionData {
    let name: String
    let items: [SampleCollectionData]
}

struct SectionCollectionModel {
    let name: String
    let items: [CollectionViewCellModel]
}
