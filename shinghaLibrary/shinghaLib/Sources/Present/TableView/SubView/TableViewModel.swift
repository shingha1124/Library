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
        SampleDataModel(name: "SectionA", cellModels: [
            TableModel(title: "a1"),
            TableModel(title: "a2"),
            TableModel(title: "a3"),
            TableModel(title: "a4"),
            TableModel(title: "a5")
        ]),
        SampleDataModel(name: "SectionB", cellModels: [
            TableModel(title: "b1"),
            TableModel(title: "b2"),
            TableModel(title: "b3"),
            TableModel(title: "b4"),
            TableModel(title: "b5")
        ]),
        SampleDataModel(name: "SectionC", cellModels: [
            TableModel(title: "c1"),
            TableModel(title: "c2"),
            TableModel(title: "c3"),
            TableModel(title: "c4"),
            TableModel(title: "c5")
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
                    SectionTableModel(name: $0.name, cellModels: $0.cellModels.map { TableViewCellModel(model: $0) })
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
