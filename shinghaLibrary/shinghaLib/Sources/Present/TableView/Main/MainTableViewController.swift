//
//  TableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class MainTableViewController: BaseViewController, View {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCellView.self, forCellReuseIdentifier: TableViewCellView.identifier)
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainTableViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.items
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCellView.identifier, cellType: TableViewCellView.self)) { _, model, cell in
                cell.viewModel = model
            }
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = "TableView"
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
