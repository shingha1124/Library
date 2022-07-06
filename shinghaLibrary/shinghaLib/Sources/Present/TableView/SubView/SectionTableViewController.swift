//
//  SectionTableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class SectionTableViewController: BaseViewController, View {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        return tableView
    }()
    
    private let tableDataSource = SectionTableViewDataSource()
    private let tableDelegateHandler = SectionTableViewDelegate()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: TableViewModel) {
        
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.sectionModels
            .bind(onNext: tableDataSource.updateModels(_:))
            .disposed(by: disposeBag)
        
        viewModel.state.sectionModels
            .bind(onNext: tableDelegateHandler.updateModels(_:))
            .disposed(by: disposeBag)
        
        viewModel.state.reloadData
            .bind(onNext: tableView.reloadData)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = TableViewType.dataSourceToSection.title
        view.backgroundColor = .white
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegateHandler
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

final class SectionTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var models: [SectionTableModel] = []
    
    func updateModels(_ models: [SectionTableModel]) {
        self.models = models
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = models[indexPath.section].items[indexPath.item]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        models[section].name
//    }
}

final class SectionTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var models: [SectionTableModel] = []
    
    func updateModels(_ models: [SectionTableModel]) {
        self.models = models
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as? TableHeaderView else {
            return UITableViewHeaderFooterView()
        }
        header.title = models[section].name
        return header
    }
}
