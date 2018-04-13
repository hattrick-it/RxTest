//
//  HomeCoordinator.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/9/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomeCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = false
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.selectedBreed.do(onNext: { [weak self] (breed) in
            let viewModel = BreedImageViewModel()
            viewModel.breedVariable.value = breed
            let viewController = BreedImageViewController(viewModel: viewModel)
            let navigationController =  self?.window.rootViewController as? UINavigationController
            navigationController?.pushViewController(viewController, animated: true)
        }).subscribe().disposed(by: disposeBag)
        
        return Observable.never()
    }
    
}
