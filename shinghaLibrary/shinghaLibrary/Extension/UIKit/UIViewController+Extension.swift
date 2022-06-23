//
//  UIViewController+Extension.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/09.
//

import UIKit

extension UIViewController {
    var topMost: UIViewController? {
        self.topMost(of: self)
    }
    
    private func topMost(of viewController: UIViewController?) -> UIViewController? {
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }

        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }

        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }

        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }

        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }

        return viewController
    }
    
    func embed(_ viewController: UIViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
