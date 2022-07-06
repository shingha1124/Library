//
//  ExampleTableViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxRelay
import RxSwift

final class TableViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let cellModels = PublishRelay<[TableViewCellModel]>()
        let sectionModels = PublishRelay<[SectionTableModel]>()
        let reloadData = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let sampleData = [
        SampleTableSectionData(name: "SectionA", cellModels: [
            SampleTableData(title: "a1"),
            SampleTableData(title: "a2"),
            SampleTableData(title: "a3"),
            SampleTableData(title: "a4"),
            SampleTableData(title: "a5")
        ]),
        SampleTableSectionData(name: "SectionB", cellModels: [
            SampleTableData(title: "b1"),
            SampleTableData(title: "b2"),
            SampleTableData(title: "b3"),
            SampleTableData(title: "b4"),
            SampleTableData(title: "b5")
        ]),
        SampleTableSectionData(name: "SectionC", cellModels: [
            SampleTableData(title: "c1"),
            SampleTableData(title: "c2"),
            SampleTableData(title: "c3"),
            SampleTableData(title: "c4"),
            SampleTableData(title: "c5")
        ])
    ]
    
    init(coordinator: MainTableViewCoordinator) {
        
        let cellModels = action.viewDidLoad
            .withUnretained(self)
            .map { model, _ in
                model.sampleData.flatMap { $0.cellModels.map { TableViewCellModel(model: $0) } }
            }
            .share()
        
        cellModels
            .withUnretained(self)
            .do { model, cellModels in
                model.state.cellModels.accept(cellModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
        
        let sectionModels = action.viewDidLoad
            .withUnretained(self)
            .map { model, _ in
                model.sampleData.map {
                    SectionTableModel(name: $0.name, items: $0.cellModels.map { TableViewCellModel(model: $0) })
                }
            }
            .share()
        
        sectionModels
            .withUnretained(self)
            .do { model, sectionModels in
                model.state.sectionModels.accept(sectionModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
    }
}
