//
//  BaseCoordinator.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/23.
//

import Foundation
import RxRelay
import RxSwift

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let disposeBag = DisposeBag()
    let startView = PublishRelay<Void>()
    
    init(navigationController: UINavigationController) {
        
    }
    
    func bind() { }
}
