//
//  MainView.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/05/01.
//

import UIKit

class MainViewController: UIViewController {
    
    init(viewModel: MainViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
