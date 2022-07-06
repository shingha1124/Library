//
//  MainCollectionViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import RxSwift
import UIKit

final class MainCollectionViewController: BaseViewController, View {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainCollectionViewCell.self, forCellReuseIdentifier: MainCollectionViewCell.identifier)
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainCollectionViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.items
            .bind(to: tableView.rx.items(cellIdentifier: MainCollectionViewCell.identifier, cellType: MainCollectionViewCell.self)) { _, model, cell in
                cell.viewModel = model
            }
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = "CollectionView"
        view.backgroundColor = .white
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
