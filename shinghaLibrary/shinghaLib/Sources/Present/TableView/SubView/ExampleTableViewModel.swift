//
//  ExampleTableViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxRelay
import RxSwift

final class ExampleTableViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let cellModels = PublishRelay<[ExampleTableViewCellModel]>()
        let sectionModels = PublishRelay<[String: [ExampleTableViewCellModel]]>()
        let reloadData = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let sampleData = [
        "SectionA": [
            ExampleTableModel(title: "a1"),
            ExampleTableModel(title: "a2"),
            ExampleTableModel(title: "a3"),
            ExampleTableModel(title: "a4"),
            ExampleTableModel(title: "a5")
        ],
        "SectionB": [
            ExampleTableModel(title: "b1"),
            ExampleTableModel(title: "b2"),
            ExampleTableModel(title: "b3"),
            ExampleTableModel(title: "b4"),
            ExampleTableModel(title: "b5")
        ],
        "SectionC": [
            ExampleTableModel(title: "c1"),
            ExampleTableModel(title: "c2"),
            ExampleTableModel(title: "c3"),
            ExampleTableModel(title: "c4"),
            ExampleTableModel(title: "c5")
        ]
    ]
    
    init(coordinator: MainTableViewCoordinator) {
        
        let cellModels = action.viewDidLoad
            .withUnretained(self)
            .map { model, _ in
                model.sampleData.flatMap { $0.value.compactMap { ExampleTableViewCellModel(model: $0) } }
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
                model.sampleData.reduce(into: [String: [ExampleTableViewCellModel]]()) {
                    $0[$1.key] = $1.value.map { ExampleTableViewCellModel(model: $0) }
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
