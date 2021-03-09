//
//  APICore.swift
//  APP
//
//  Created by Nha Duong on 2/19/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation
import Alamofire

class APICore {
  private let manager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 60
    return Alamofire.SessionManager(configuration: configuration)
  }()
  
  func cancelAllrequest(completionHandler: (() -> ())?) {
    if #available(iOS 9.0, *) {
      manager.session.getAllTasks { tasks in
        tasks.forEach({ $0.cancel() })
        completionHandler?()
      }
    }
  }
  
  func requestJSON(_ request: APIRequest, completion: @escaping APICompletion) {
      //call service
      manager.request(request.url.value, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: request.headers)
        .responseJSON { (response) in
          var apiResponse: APIResponse!
          let status = response.response?.statusCode ?? 0
          if status == 200 {
            let result = response.result.value as? APIJSON
            apiResponse = APIResponse(status: .success, result: result)
          } else {
            apiResponse = APIResponse(status: .fail(status: response.response?.statusCode ?? 0, message: ""), result: nil)
          }
          completion(apiResponse)
    }
  }
}
