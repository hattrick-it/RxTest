//
//  HomeViewController.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/9/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController : UIViewController {
    
    @IBOutlet weak var breedsTableView: UITableView!
    
    var viewModel: HomeViewModel
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle methods
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getBreeds.onNext(())
    }
    
    // MARK: Private methods
    
    fileprivate func setupTableView() {
        breedsTableView.tableFooterView = UIView()
        breedsTableView.register(UINib(nibName: "BreedTableViewCell", bundle: nil), forCellReuseIdentifier: BreedTableViewCell.cellReuseIdentifier)
    }
    
    fileprivate func setupBindings() {
        viewModel.breeds
            .bind(to: breedsTableView.rx.items(cellIdentifier: BreedTableViewCell.cellReuseIdentifier, cellType: BreedTableViewCell.self)) { (row, breed, cell) in
                cell.configure(with: breed)
            }
            .disposed(by: disposeBag)
        
        viewModel.error.do(onNext: { errorMessage in
            self.showAlert(withTitle: "Error".localized, message:errorMessage.localized, buttonTitle: "OK")
        }).subscribe().disposed(by: disposeBag)
    }
    
}
