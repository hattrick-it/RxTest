//
//  Result.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/10/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Result<T> {
    
    case success(T?)
    case error(ResultError)
    
}

extension Result where T: Mappable {
    
    init(json: JSON?) {
        if let json = json {
            if let jsonStatus = json["status"].string {
                if (jsonStatus == "success") {
                    self = .success(T(json: json["message"]))
                } else {
                    self = .error(ResultError(json: json))
                }
            } else {
                self = .error(ResultError(type: .noType))
            }
        } else {
            self = .error(ResultError(type: .noType))
        }
    }
    
}
