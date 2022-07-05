//
//  ExampleTableViewCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxRelay
import RxSwift

final class TableViewCellModel: ViewModel {
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let title = PublishRelay<String>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(model: TableModel) {
        action.loadData
            .map { model.title }
            .bind(to: state.title)
            .disposed(by: disposeBag)
        
    }
}
