//
//  ExampleTableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class ExampleTableViewController: BaseViewController, View {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        return tableView
    }()
    
    private let tableDataSource = ExampleTableViewDataSource()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: ExampleTableViewModel) {
        
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.cellModels
            .bind(onNext: tableDataSource.updateModels(_:))
            .disposed(by: disposeBag)
        
        viewModel.state.reloadData
            .bind(onNext: tableView.reloadData)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = "With DataSource"
        view.backgroundColor = .white
        tableView.dataSource = tableDataSource
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

final class ExampleTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var models: [ExampleTableViewCellModel] = []
    
    func updateModels(_ models: [ExampleTableViewCellModel]) {
        self.models = models
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as? ExampleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = models[indexPath.item]
        return cell
    }
}
