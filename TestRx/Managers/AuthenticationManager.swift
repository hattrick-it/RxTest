//
//  AuthenticationManager.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/4/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import RxSwift

enum LoginResult {
    case success
    case wrongCredentials
}

class AuthenticationManager {
    
    struct AuthenticationCredentials: Equatable {
        let email: String
        let password: String
        
        static func ==(lhs: AuthenticationManager.AuthenticationCredentials, rhs: AuthenticationManager.AuthenticationCredentials) -> Bool {
            return (lhs.email == rhs.email) && (lhs.password == rhs.password)
        }
    }
    
    static let sharedInstance = AuthenticationManager()
    
    var trySigning: AnyObserver<AuthenticationCredentials>
    var signInResult: Observable<LoginResult>
    
    init() {
        let _trySigning = PublishSubject<AuthenticationCredentials>()
        trySigning = _trySigning.asObserver()
        signInResult = _trySigning.asObservable().map { (authCredentials) -> LoginResult in
            let userCredentials = AuthenticationCredentials(email: "Test", password: "TestPass")
            let result: LoginResult
            let credentialsOk = authCredentials == userCredentials
            credentialsOk ? (result = LoginResult.success) : (result = LoginResult.wrongCredentials)
            return result
        }
    }
}
