//
//  MainCoordinator.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/23.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit

final class MainCoordinator: Coordinator {
    private let navigationController: UINavigationController
    let disposeBag = DisposeBag()
    var childCoordinators = [Coordinator]()
    let startView = PublishRelay<Void>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        bind()
    }
    
    func bind() {
        startView
            .bind(onNext: presentMainView) 
            .disposed(by: disposeBag)
    }
}

extension MainCoordinator {
    private func presentMainView() {
        let viewModel = MainViewModel(mainCoordinator: self)
        let viewController = MainViewController()
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }
}
