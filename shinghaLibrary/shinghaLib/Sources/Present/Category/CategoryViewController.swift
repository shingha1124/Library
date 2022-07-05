//
//  MainView.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import RxAppState
import RxSwift
import SnapKit
import UIKit

class CategoryViewController: BaseViewController, View { 
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: CategoryViewCell.identifier)
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: CategoryViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.mainItems
            .bind(to: tableView.rx.items(cellIdentifier: CategoryViewCell.identifier, cellType: CategoryViewCell.self)) { _, model, cell in
                cell.viewModel = model
            }
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = "Category"
        view.backgroundColor = .white
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
