//
//  Breed.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/10/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import SwiftyJSON

class Breed: Mappable {
    
    var name: String
    
    required init?(json: JSON?) {
        guard let name = json?.string else { return nil }
        self.name = name
        
        super.init(json: json)
    }
    
    required init() {
        self.name = ""
        
        super.init()
    }
    
}
