//
//  Rx+NotificationCenter+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/09.
//

import Foundation
import RxSwift
import RxCocoa

extension NotificationCenter {
    static var keyboardWillShowHeight: Observable<CGFloat> {
        NotificationCenter.default.rx.notification(UIWindow.keyboardWillShowNotification)
            .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height }
    }
    static var keyboardWillHideHeight: Observable<CGFloat> {
        NotificationCenter.default.rx.notification(UIWindow.keyboardWillHideNotification)
            .map { _ in 0 }
    }
}
