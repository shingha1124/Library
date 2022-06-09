//
//  UITextField+Extension.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/09.
//

import UIKit

extension UITextField {
    func leftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
