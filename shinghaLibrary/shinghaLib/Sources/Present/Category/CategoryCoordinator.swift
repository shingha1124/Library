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

final class CategoryCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    let disposeBag = DisposeBag()
    var childCoordinators = [Coordinator]()
    let startView = PublishRelay<Void>()
    let presentView = PublishRelay<CategoryType>()
    
    private lazy var subCoordinators: [CategoryType: Coordinator] = [
        .tableView: TableViewCoordinator(navigationController: navigationController)
    ]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        bind()
    }
    
    func bind() {
        startView
            .bind(onNext: presentMainView)
            .disposed(by: disposeBag)
        
        presentView
            .withUnretained(self)
            .compactMap { coordinator, type in coordinator.subCoordinators[type] }
            .bind(onNext: {
                $0.startView.accept(())
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryCoordinator {
    private func presentMainView() {
        let viewModel = CategoryViewModel(mainCoordinator: self)
        let viewController = CategoryViewController()
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }
}
