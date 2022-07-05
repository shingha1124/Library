//
//  ExampleTableViewCell.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import Foundation
import UIKit

final class ExampleTableViewCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        attribute()
//        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
