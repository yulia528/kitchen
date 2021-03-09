//
//  Dictionary.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/24/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation

extension Dictionary {
    static func +(lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var result = lhs
        for key in rhs.keys {
            result[key] = rhs[key]
        }
        
        return result
    }
    
    static func +=(lhs: inout Dictionary, rhs: Dictionary) {
        for key in rhs.keys {
            lhs[key] = rhs[key]
        }
    }
}
