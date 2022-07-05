//
//  TableHeaderView.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import UIKit

final class TableHeaderView: UITableViewHeaderFooterView {
    static var identifier: String { .init(describing: self) }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attribute() {
        
    }

    func layout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
