//
//  Coordinator.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/23.
//

import RxRelay
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var startView: PublishRelay<Void> { get }
    
    func bind()
}

extension Coordinator {
    
    func store(coordinator: Coordinator) {
      childCoordinators.append(coordinator)
    }
    
    func free(coordinator: Coordinator) {
      childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func clear() {
        childCoordinators.removeAll()
    }
}
