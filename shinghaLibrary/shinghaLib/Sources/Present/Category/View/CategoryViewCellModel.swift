//
//  MainViewCellModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/23.
//

import Foundation
import RxRelay
import RxSwift

final class CategoryViewCellModel: ViewModel {
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Void>()
        let tappedCellWithType = PublishRelay<CategoryType>()
    }
    
    struct State {
        let title = PublishRelay<String>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(itemType: CategoryType) {
        action.loadData
            .map { itemType.title }
            .bind(to: state.title)
            .disposed(by: disposeBag)
        
        action.tappedCell
            .map { itemType }
            .bind(to: action.tappedCellWithType)
            .disposed(by: disposeBag)
    }
}
