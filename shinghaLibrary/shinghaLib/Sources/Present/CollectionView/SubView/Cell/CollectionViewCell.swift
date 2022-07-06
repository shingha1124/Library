//
//  CollectionViewCell.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import RxSwift
import UIKit

final class CollectionViewCell: BaseCollectionViewCell, View {
    
    func bind(to viewModel: CollectionViewCellModel) {
        viewModel.state.backgroundColor
            .map { $0.hexToColor() }
            .bind(to: rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.action.loadData.accept(())
    }
}
