//
//  MainView.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import RxSwift
import UIKit

class MainViewController: BaseViewController, View {
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainViewModel) {
        view.backgroundColor = .white
    }
}
