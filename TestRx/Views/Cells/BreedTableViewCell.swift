//
//  BreedTableViewCell.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/9/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit

class BreedTableViewCell: UITableViewCell {
    
    static let cellReuseIdentifier = "BreedTableViewCell"
    
    @IBOutlet weak var breedNameLabel: UILabel!
    
    func configure(with breed: Breed) {
        breedNameLabel.text = breed.name.capitalizedFirstLetter()
    }
    
}
