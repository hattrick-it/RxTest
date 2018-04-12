//
//  LoginViewController.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/2/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    let email = Variable<String>("")
    let password = Variable<String>("")
    
    // MARK: - Inputs
    
    let tryLogin: AnyObserver<Void>
    
    // MARK: - Outputs

    let isValid: Observable<Bool>
    let didLogin: Observable<Void>
    let errorMessage: Observable<String>
    
    init() {
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
        { (user, password) in
            return user.count > 0 && password.count > 0
        }
        
        let _tryLogin = PublishSubject<Void>()
        tryLogin = _tryLogin.asObserver()
        
        didLogin = AuthenticationManager.sharedInstance.signInResult.filter {
            $0 == .success
            }.map {_ in }
        
        errorMessage = AuthenticationManager.sharedInstance.signInResult.filter {
            $0 != .success
            }.map {result in "Wrong credentials"}
        
        _tryLogin.asObservable().map { [weak self] () -> AuthenticationManager.AuthenticationCredentials in
            AuthenticationManager.AuthenticationCredentials(email: self?.email.value ?? "", password: self?.password.value ?? "")
            }.bind(to: AuthenticationManager.sharedInstance.trySigning).disposed(by: disposeBag)
    }
    
}


