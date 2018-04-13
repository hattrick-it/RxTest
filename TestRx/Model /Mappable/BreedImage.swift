//
//  BreedImage.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/11/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import Foundation
import SwiftyJSON

class BreedImage: Mappable {
    
    var imageUrl: String
    
    required init?(json: JSON?) {
        guard let imageUrl = json?.string else { return nil }
        self.imageUrl = imageUrl
        
        super.init(json: json)
    }
    
    required init() {
        imageUrl = ""
        
        super.init()
    }
    
}
