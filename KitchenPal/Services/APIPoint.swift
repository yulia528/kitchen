//
//  APIPoint.swift
//  APP
//
//  Created by Nha Duong on 2/19/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//
import Foundation

class APIPoint {
    private(set) var server: String
    init(server: String) {
        self.server = server
    }
    
    func endPoint(service: APIServiceProtocol) -> APIURL {
        let endPoint = server + "/" + service.value
        return APIURL(value: endPoint)
    }
  
  func endPoint(withEnd endString: String) -> APIURL {
    let endPoint = server + endString
    return APIURL(value: endPoint)
  }
}

protocol APIServiceProtocol {
  var value: String { get }
}

