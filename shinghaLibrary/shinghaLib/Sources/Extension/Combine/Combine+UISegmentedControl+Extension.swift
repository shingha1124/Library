//
//  UISegmentedControl+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Combine
import UIKit

extension UISegmentedControl {
    //Segment Combine Publisher
    func publisher() -> AnyPublisher<Int, Never> {
        EventPublisher<Int>(control: self, event: .valueChanged, receiveClosure: {
            self.selectedSegmentIndex
        }).eraseToAnyPublisher()
    }
}
