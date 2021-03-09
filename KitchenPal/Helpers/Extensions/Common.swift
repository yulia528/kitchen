//
//  Common.swift
//  APP
//
//  Created by Nha Duong on 2/18/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation
import UIKit

protocol TypeName {
    static var typeName: String { get }
}

//Swift Objects
extension TypeName {
    static var typeName: String {
        return String(describing: self)
    }
}

// Bridge to Obj-C
extension NSObject: TypeName {
    class var typeName: String {
        return String(describing: self)
    }
}
