//
//  LoginViewController.swift
//  TestRx
//
//  Created by Rocket League on 4/2/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    fileprivate func setupBindings() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.tryLogin)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage.do(onNext: { errorMessage in
            self.showAlert(withTitle: "Error", message:errorMessage, buttonTitle: "OK")
        }).subscribe().disposed(by: disposeBag)
    }
    
}
