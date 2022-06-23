//
//  Coordinator.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
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
    
    func find<T: BaseCoordinator>(type: T.Type) -> BaseCoordinator? {
        for coordinator in childCoordinators {
            if let coordnator = coordinator as? T {
                return coordnator
            }
        }
        return nil
    }
}
