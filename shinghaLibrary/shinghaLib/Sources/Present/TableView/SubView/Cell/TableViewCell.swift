//
//  ExampleTableViewCell.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class TableViewCell: BaseTableViewCell, View {
    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func bind(to viewModel: TableViewCellModel) {
        viewModel.state.title
            .bind(to: title.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.action.loadData.accept(())
    }
    
    override func layout() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
