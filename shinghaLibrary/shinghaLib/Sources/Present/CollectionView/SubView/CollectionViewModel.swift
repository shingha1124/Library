//
//  CollectionViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import Foundation
import RxRelay
import RxSwift

final class CollectionViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let sectionModels = PublishRelay<[SectionCollectionModel]>()
        let reloadData = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let sampleData = [
        SampleCollectionSectionData(name: "SectionA", items: [
            SampleCollectionData(id: 1),
            SampleCollectionData(id: 2),
            SampleCollectionData(id: 3),
            SampleCollectionData(id: 4),
            SampleCollectionData(id: 5)
        ]),
        SampleCollectionSectionData(name: "SectionB", items: [
            SampleCollectionData(id: 1),
            SampleCollectionData(id: 2),
            SampleCollectionData(id: 3),
            SampleCollectionData(id: 4),
            SampleCollectionData(id: 5)
        ]),
        SampleCollectionSectionData(name: "SectionC", items: [
            SampleCollectionData(id: 1),
            SampleCollectionData(id: 2),
            SampleCollectionData(id: 3),
            SampleCollectionData(id: 4),
            SampleCollectionData(id: 5)
        ])
    ]
    
    init(coordinator: MainCollectionViewCoordinator) {
        
        let sectionModels = action.viewDidLoad
            .withUnretained(self)
            .map { model, _ in
                model.sampleData.map {
                    SectionCollectionModel(name: $0.name, items: $0.items.map { CollectionViewCellModel(data: $0) })
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
