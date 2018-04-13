//
//  BreedImageViewController.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/11/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BreedImageViewController : UIViewController {
    
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var breedImageView: UIImageView!
    
    var viewModel: BreedImageViewModel
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle methods
    
    init(viewModel: BreedImageViewModel) {
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
    
    // MARK: Private methods
    
    fileprivate func setupBindings() {
        viewModel.selectedBreed.do(onNext: { [weak self] (breed) in
            self?.breedNameLabel.text = breed.name.capitalizedFirstLetter()
            self?.viewModel.getBreedImage.onNext(breed)
        }).subscribe().disposed(by: disposeBag)
        
        viewModel.selectedBreedImage.do(onNext: { [weak self] (breedImage) in
            self?.breedImageView.setImage(withStringURL: breedImage?.imageUrl)
        }).subscribe().disposed(by: disposeBag)
        
        viewModel.error.do(onNext: { errorMessage in
            self.showAlert(withTitle: "Error".localized, message:errorMessage.localized, buttonTitle: "OK")
        }).subscribe().disposed(by: disposeBag)
    }
    
}

