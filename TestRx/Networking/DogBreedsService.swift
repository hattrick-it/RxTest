//
//  DogBreedsService.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/6/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import Moya

enum ApiVersion: String {
    case none = ""
}

enum DogBreedsService {
    case breeds()
    case breedImage(name: String)
}

extension DogBreedsService : TargetType {
    
    var apiVersion: ApiVersion { return .none }
    
    // MARK: - TargetType Protocol Implementation
    var baseURL: URL { return URL(string: ConfigurationManager.sharedInstance.serverBaseURL + apiVersion.rawValue )! }
    
    var path: String {
        switch self {
        case .breeds:
            return "/breeds/list"
        case .breedImage(let name):
            return "/breed/\(name)/images/random"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
