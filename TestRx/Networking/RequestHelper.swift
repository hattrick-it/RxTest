//
//  RequestHelper.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/6/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import RxSwift

typealias Endpoint = DogBreedsService

class RequestHelper {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Singleton
    fileprivate static let instance = RequestHelper()
    
    class func sharedInstance() -> RequestHelper {
        return instance
    }
    
    fileprivate var provider: MoyaProvider<DogBreedsService>
    
    init(){
        provider = MoyaProvider<DogBreedsService>()
    }
    
    func performRequest<T: Mappable>(endopoint: Endpoint, jsonEncoding: Bool = true) -> Observable<Result<T>> {
        return provider.rx.request(endopoint).map { response -> Result<T> in
            Result(json: JSON(response.data))
        }.asObservable()
    }
    
    func performRequest<T: Mappable>(endopoint: Endpoint, jsonEncoding: Bool = true) -> Observable<ResultCollection<T>> {
        return provider.rx.request(endopoint).map { response -> ResultCollection<T> in
            return ResultCollection(json: JSON(response.data))
        }.asObservable()
    }
    
}

