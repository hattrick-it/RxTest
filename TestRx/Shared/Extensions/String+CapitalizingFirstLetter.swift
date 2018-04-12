//
//  String+CapitalizingFirstLetter.swift
//  TestRx
//
//  Created by Esteban Arrua on 4/12/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizedFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
}
