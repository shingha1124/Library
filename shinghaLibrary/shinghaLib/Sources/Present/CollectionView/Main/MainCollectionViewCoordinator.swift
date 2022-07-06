//
//  CollectionViewCoordinator.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import RxRelay
import RxSwift
import UIKit

final class MainCollectionViewCoordinator: Coordinator {
    private let navigationController: UINavigationController
    let disposeBag = DisposeBag()
    var childCoordinators = [Coordinator]()
    let startView = PublishRelay<Void>()
    let present = PublishRelay<CollectionViewType>()
    
    private lazy var presentEvents: [CollectionViewType: () -> Void] = [
        .flowLayout: presentFlowLayout
    ]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        bind()
    }
    
    func bind() {
        startView
            .bind(onNext: presentMainView)
            .disposed(by: disposeBag)
        
        present
            .withUnretained(self)
            .bind(onNext: { coordinator, type in
                coordinator.presentEvents[type]?()
            })
            .disposed(by: disposeBag)
    }
}

extension MainCollectionViewCoordinator {
    private func presentMainView() {
        let viewModel = MainCollectionViewModel(coordinator: self)
        let viewController = MainCollectionViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentFlowLayout() {
        let viewModel = CollectionViewModel(coordinator: self)
        let viewController = CollectionFlowLayoutViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
}
