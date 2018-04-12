//
//  ResultColletion.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/10/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ResultCollection<T> {
    
    case success([T])
    case error(ResultError)
    
}

extension ResultCollection where T: Mappable {
    
    init(json: JSON?) {
        if let json = json {
            if let jsonStatus = json["status"].string {
                if (jsonStatus == "success") {
                    self = .success(json["message"].arrayValue.compactMap { T.init(json: $0) })
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
