//
//  Combine+UITextView+Extension.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/09.
//

import Combine
import UIKit

extension UITextView {
    func changePublisher() -> AnyPublisher<UITextView, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self )
            .map { _ in self }
            .eraseToAnyPublisher()
    }
    
    func beginEditingPublisher() -> AnyPublisher<UITextView, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidBeginEditingNotification, object: self )
            .map { _ in self }
            .eraseToAnyPublisher()
    }
    
    func endEditingPublisher() -> AnyPublisher<UITextView, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidBeginEditingNotification, object: self )
            .map { _ in self }
            .eraseToAnyPublisher()
    }
}
