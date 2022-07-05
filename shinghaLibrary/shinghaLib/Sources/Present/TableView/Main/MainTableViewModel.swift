//
//  TableViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxRelay
import RxSwift

final class MainTableViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let items = PublishRelay<[TableViewCellViewModel]>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(coordinator: MainTableViewCoordinator) {
        let cellViewModels = action.viewDidLoad
            .map { TableViewType.allCases.map { TableViewCellViewModel(type: $0) } }
            .share()
        
        cellViewModels
            .bind(to: state.items)
            .disposed(by: disposeBag)
        
        let tappedCell = cellViewModels
            .flatMapLatest { viewModels -> Observable<TableViewType> in
                let tappedCells = viewModels.map { $0.action.tappedCellWithType.asObservable() }
                return .merge(tappedCells)
            }
            .share()
        
        tappedCell
            .bind(to: coordinator.present)
            .disposed(by: disposeBag)
    }
}
