//
//  MainViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import Foundation
import RxRelay
import RxSwift

class CategoryViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let mainItems = PublishRelay<[CategoryViewCellModel]>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(mainCoordinator: CategoryCoordinator) {
        let cellViewModels = action.viewDidLoad
            .map { CategoryType.allCases.map { CategoryViewCellModel(itemType: $0) } }
            .share()
        
        cellViewModels
            .bind(to: state.mainItems)
            .disposed(by: disposeBag)
        
        let tappedCell = cellViewModels
            .flatMapLatest { viewModels -> Observable<CategoryType> in
                let tappedCells = viewModels.map { $0.action.tappedCellWithType.asObservable() }
                return .merge(tappedCells)
            }
            .share()
        
        tappedCell
            .bind(to: mainCoordinator.presentView)
            .disposed(by: disposeBag)
    }
}
