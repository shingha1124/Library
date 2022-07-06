//
//  SectionRxTableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import RxDataSources
import RxSwift
import UIKit

final class SectionRxTableViewController: BaseViewController, View {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: TableViewModel) {
        
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TableViewCellModel>>(configureCell: { _, tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = model
            return cell
        }, titleForHeaderInSection: { dataSource, section in
            dataSource.sectionModels[section].model
        })
        
        viewModel.state.sectionModels
            .map { $0.map { SectionModel<String, TableViewCellModel>(model: $0.name, items: $0.items) } }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = TableViewType.dataSourceToSection.title
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
