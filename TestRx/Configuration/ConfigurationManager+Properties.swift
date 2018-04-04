//
//  ConfigurationManager+Properties.swift
//  TestRx
//
//  Created by Rocket League on 4/2/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import Foundation

extension ConfigurationManager {
    static var environment: Environment {
        return Environment(rawValue: ConfigurationManager.currentConfiguration as! String)!
    }
    
    var serverBaseURL: String {
        return configs["SERVER_BASE_URL"]!
    }
}
