//
//  ExampleRxTableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class RxTableViewController: BaseViewController, View {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: TableViewModel) {
        
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.cellModels
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { _, model, cell in
                cell.viewModel = model
            }
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = "With RxSwift"
        view.backgroundColor = .white
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
