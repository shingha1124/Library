//
//  TableViewCoordinator.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxRelay
import RxSwift
import UIKit

final class MainTableViewCoordinator: Coordinator {
    private let navigationController: UINavigationController
    let disposeBag = DisposeBag()
    var childCoordinators = [Coordinator]()
    let startView = PublishRelay<Void>()
    let present = PublishRelay<TableViewType>()
    
    private lazy var presentEvents: [TableViewType: () -> Void] = [
        .cellWithDataSource: presentBaseTableView,
        .cellWithRxSwift: presentRxTableView,
        .sectionWithDataSource: presentSectionTableView
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

extension MainTableViewCoordinator {
    private func presentMainView() {
        let viewModel = MainTableViewModel(coordinator: self)
        let viewController = MainTableViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentBaseTableView() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = TableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentRxTableView() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = RxTableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentSectionTableView() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = SectionTableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
}
