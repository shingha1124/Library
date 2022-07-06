//
//  CollectionViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/06.
//

import RxSwift
import UIKit

final class CollectionFlowLayoutViewController: BaseViewController, View {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    let dataSource = CollectionFlowLayoutDataSource()
    
    func bind(to viewModel: CollectionViewModel) {
        
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state.sectionModels
            .bind(onNext: dataSource.updateModels(_:))
            .disposed(by: disposeBag)
        
        viewModel.state.reloadData
            .bind(onNext: collectionView.reloadData)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        title = CollectionViewType.flowLayout.title
        view.backgroundColor = .white
        collectionView.dataSource = dataSource
    }
    
    override func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

class CollectionFlowLayoutDataSource: NSObject, UICollectionViewDataSource {
    
    private var sectionModel: [SectionCollectionModel] = []
    
    func updateModels(_ models: [SectionCollectionModel]) {
        self.sectionModel = models
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionModel[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = sectionModel[indexPath.section].items[indexPath.item]
        return cell
    }
}
