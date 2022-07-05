//
//  ExampleTableViewModel.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import RxSwift

final class ExampleTableViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init(coordinator: TableViewCoordinator) {
    }
}
