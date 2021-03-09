//
//  APIConstant.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/21/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation
import Alamofire
// MARK: Type

typealias APIJSON = Parameters
typealias APICompletion = (_ response: APIResponse) -> Void
typealias APIMethod = HTTPMethod
typealias APIHeader = HTTPHeaders

enum APIResponseStatus {
  case fail(status: Int, message: String?)
  case success
}

struct APIResponse {
  let status: APIResponseStatus
  let result: APIJSON?
}

struct APIURL {
  let value: String
}

struct APIRequest {
  let url: APIURL
  let method: APIMethod
  var parameters: APIJSON?
  var headers: APIHeader?
}
