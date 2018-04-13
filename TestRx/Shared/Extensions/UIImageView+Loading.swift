//
//  UIImageView+Loading.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/13/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(withStringURL stringURL: String?, placeholder: UIImage? = nil) {
        guard let stringURL = stringURL else {
            self.image = placeholder
            return
        }
        
        let url = URL(string: stringURL)
        self.kf.setImage(with: url, placeholder: placeholder)
    }
    
}
