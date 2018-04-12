//
//  LoginCoordinator.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/4/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class LoginCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return viewModel.didLogin.map { _ in }.do(onNext: {
            self.window.rootViewController?.dismiss(animated: true, completion: nil)
        })
    }
    
}
