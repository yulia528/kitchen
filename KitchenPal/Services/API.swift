//
//  API.swift
//  APP
//
//  Created by Nha Duong on 2/19/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//
let KITCHEN_SERVER = "http://kitchenpal.smartdev.vn:8080/v1"

import Foundation

class API: APICore {
    static let shared: API = {
        let instance = API()
        return instance
    }()

    let kitchenPoint = APIPoint(server: KITCHEN_SERVER)
    private override init() {
        super.init()
    }
    
    var headers: [String: String] {
        var headers_ = [String: String]()
        headers_ += DataManagement.shared.authorizationData.httpHeader
        headers_ += AppSetting.shared.language.httpHeader
        return headers_
    }
    
    override func requestJSON(_ request: APIRequest, completion: @escaping APICompletion) {
        if let _ = request.headers {
            return super.requestJSON(request, completion: completion)
        } else {
            var newRequest = request
            newRequest.headers = self.headers
            return super.requestJSON(newRequest, completion: completion)
        }
    }
}
