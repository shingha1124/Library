//
//  RootWindow.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import Combine
import UIKit

class RootWindow: UIWindow {
    private var cancellables = Set<AnyCancellable>()
    let switchRootWindowState = PassthroughSubject<State, Never>()
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        overrideUserInterfaceStyle = .light
        rootViewController = RootWindow.State.main.viewController
        
        switchRootWindowState
            .compactMap { $0.viewController }
            .sink {
                self.rootViewController = $0
            }.store(in: &cancellables)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootWindow {
    enum State {
        case main
        
        var viewController: UIViewController {
            switch self {
            case .main:
                return MainViewController(viewModel: MainViewModel())
            }
        }
    }
}
