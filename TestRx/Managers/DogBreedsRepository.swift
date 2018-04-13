//
//  DogBreedsRepository.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/6/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import RxSwift

class DogBreedsRepository {
    
    let disposeBag = DisposeBag()
    
    static let sharedInstance = DogBreedsRepository()
    
    // MARK: - Public methods
    
    func getBreeds() -> Observable<ResultCollection<Breed>> {
        return RequestHelper.sharedInstance().performRequest(endopoint: .breeds())
    }
    
    func getImageBreed(name: String) -> Observable<Result<BreedImage>> {
        return RequestHelper.sharedInstance().performRequest(endopoint: .breedImage(name: name))
    }
    
}
