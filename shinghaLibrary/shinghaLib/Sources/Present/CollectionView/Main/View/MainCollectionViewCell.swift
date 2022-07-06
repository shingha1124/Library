//
//  CollectionViewCell.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import UIKit

final class MainCollectionViewCell: BaseTableViewCell, View {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    func bind(to viewModel: MainCollectionViewCellModel) {
        
        viewModel.state.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.action.tappedCell)
            .disposed(by: disposeBag)
        
        viewModel.action.loadData.accept(())
    }
    
    override func layout() {
        contentView.addSubview(titleLabel)
        addSubview(button)
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
