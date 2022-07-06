//
//  CollectionViewCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import Foundation
import RxRelay
import RxSwift

final class CollectionViewCellModel: ViewModel {
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let backgroundColor = PublishRelay<String>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(data: SampleCollectionData) {
        action.loadData
            .map { data.hexColor }
            .bind(to: state.backgroundColor)
            .disposed(by: disposeBag)
    }
}
