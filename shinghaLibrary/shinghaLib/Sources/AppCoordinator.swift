//
//  AppCoordinator.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/23.
//

import RxRelay
import RxSwift
import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private lazy var mainCoordinator: MainCoordinator = {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        return mainCoordinator
    }()
    
    var childCoordinators = [Coordinator]()
    let disposeBag = DisposeBag()
    let startView = PublishRelay<Void>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        bind()
    }
    
    func bind() {
        startView
            .bind(to: mainCoordinator.startView)
            .disposed(by: disposeBag)
    }
}
