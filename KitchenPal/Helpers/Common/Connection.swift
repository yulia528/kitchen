//
//  File.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/25/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation

class Connection {
    static func isConnectInternet() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .offline, .unknown:
            return false
        default:
            return true
        }
    }
}
