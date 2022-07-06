//
//  MainCollectionViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import Foundation
import Foundation
import RxRelay
import RxSwift

final class MainCollectionViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let items = PublishRelay<[MainCollectionViewCellModel]>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(coordinator: MainCollectionViewCoordinator) {
        let cellViewModels = action.viewDidLoad
            .map { CollectionViewType.allCases.map { MainCollectionViewCellModel(type: $0) } }
            .share()
        
        cellViewModels
            .bind(to: state.items)
            .disposed(by: disposeBag)
        
        let tappedCell = cellViewModels
            .flatMapLatest { viewModels -> Observable<CollectionViewType> in
                let tappedCells = viewModels.map { $0.action.tappedCellWithType.asObservable() }
                return .merge(tappedCells)
            }
            .share()
        
        tappedCell
            .bind(to: coordinator.present)
            .disposed(by: disposeBag)
    }
}
