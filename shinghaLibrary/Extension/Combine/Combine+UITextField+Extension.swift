//
//  TextField+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import UIKit
import Combine

extension UITextField {    
    func changedPublisher() -> AnyPublisher<String, Never> {
        EventPublisher<String>(control: self, event: .editingChanged, receiveClosure: {
            return self.text ?? ""
        }).eraseToAnyPublisher()
    }
}
