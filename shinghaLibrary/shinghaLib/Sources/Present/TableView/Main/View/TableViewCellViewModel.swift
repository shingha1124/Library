//
//  TableViewCellViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxRelay
import RxSwift

final class TableViewCellViewModel: ViewModel {
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Void>()
        let tappedCellWithType = PublishRelay<TableViewType>()
    }
    
    struct State {
        let title = PublishRelay<String>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(type: TableViewType) {
        action.loadData
            .map { type.title }
            .bind(to: state.title)
            .disposed(by: disposeBag)
        
        action.tappedCell
            .map { type }
            .bind(to: action.tappedCellWithType)
            .disposed(by: disposeBag)
    }
}
