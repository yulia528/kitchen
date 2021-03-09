//
//  KitchenServices.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/24/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation

extension API {
    func kitchenContent(param: APIJSON, completion: @escaping APICompletion)  {
        guard let userId = DataManagement.shared.userData?.userId else {
            return
        }
        
        let request = APIRequest(url: kitchenPoint.endPoint(withEnd: "/kitchens-secret/\(userId)/list?orderBy=id&sort=desc"), method: .get, parameters: nil, headers: nil)
        self.requestJSON(request, completion: completion)
    }
}
