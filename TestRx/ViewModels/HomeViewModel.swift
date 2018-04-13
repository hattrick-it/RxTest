//
//  HomeViewModel.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/9/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    
    let getBreeds: AnyObserver<Void>
    
    var selectBreed: AnyObserver<Breed> {
        return _selectedBreed.asObserver()
    }
    
    // MARK: - Outputs
    
    var breeds: Observable<[Breed]> {
        return breedsVariable.asObservable()
    }
    
    var error: Observable<String> {
        return _error.asObservable()
    }
    
    var selectedBreed: Observable<Breed> {
        return _selectedBreed.asObservable()
    }
    
    // MARK: - Private vars
    
    private let _error = PublishSubject<String>()
    private let _selectedBreed = PublishSubject<Breed>()
    private let breedsVariable = Variable<[Breed]>([])
    
    
    init() {
        let _getBreeds = PublishSubject<Void>()
        getBreeds = _getBreeds.asObserver()

        let repositoryBreeds = DogBreedsRepository.sharedInstance.getBreeds()
        
        _getBreeds.asObservable().flatMap({ _ in
            repositoryBreeds
        }).map({ [weak self] resultCollection -> [Breed] in
            switch resultCollection {
            case .success(let breedsCollection):
                return breedsCollection
            case .error(let error):
                self?._error.asObserver().onNext(error.errorType.rawValue)
                return []
            }
        }).bind(to: breedsVariable).disposed(by: disposeBag)
    }
    
}
