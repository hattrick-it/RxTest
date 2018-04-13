//
//  BreedImageViewModel.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/11/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import Foundation
import RxSwift

class BreedImageViewModel {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var breedVariable = Variable<Breed>(Breed())
    
    // MARK: - Inputs
    
    let getBreedImage: AnyObserver<Breed>
    
    // MARK: - Outputs
    
    var selectedBreed: Observable<Breed> {
        return breedVariable.asObservable()
    }
    
    var selectedBreedImage: Observable<BreedImage?> {
        return _selectedBreedImage.asObservable()
    }
    
    var error: Observable<String> {
        return _error.asObservable()
    }
    
    // MARK: - Private vars
    
    private let _error = PublishSubject<String>()
    private let _selectedBreedImage = Variable<BreedImage?>(BreedImage())
    
    init() {
        let _getBreedImage = PublishSubject<Breed>()
        getBreedImage = _getBreedImage.asObserver()
        
        _getBreedImage.asObservable().flatMap({ (breed) in
            DogBreedsRepository.sharedInstance.getImageBreed(name: breed.name)
        }).map({ [weak self] result -> BreedImage? in
            switch result {
            case .success(let breedImage):
                return breedImage
            case .error(let error):
                self?._error.asObserver().onNext(error.errorType.rawValue)
                return BreedImage()
            }
        }).bind(to: _selectedBreedImage).disposed(by: disposeBag)
    }
    
}
