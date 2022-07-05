//
//  ExampleTableViewController.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/07/05.
//

import RxSwift
import UIKit

final class ExampleTableViewController: BaseViewController, View {
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: ExampleTableViewModel) {
    }
    
    override func attribute() {
        view.backgroundColor = .red
    }
}
