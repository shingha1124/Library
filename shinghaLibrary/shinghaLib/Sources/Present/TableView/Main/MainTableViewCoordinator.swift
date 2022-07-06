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
        .dataSourceToCell: presentDataSourceToCell,
        .rxSwiftToCell: presentRxSwiftToCell,
        .dataSourceToSection: presentDataSourceToSection,
        .rxDataSourceToSection: presentRxDataSourceToSection
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
    
    private func presentDataSourceToCell() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = TableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentRxSwiftToCell() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = RxTableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentDataSourceToSection() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = SectionTableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentRxDataSourceToSection() {
        let viewModel = TableViewModel(coordinator: self)
        let viewController = SectionRxTableViewController()
        viewController.viewModel = viewModel
        navigationController.topViewController?.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }
}
