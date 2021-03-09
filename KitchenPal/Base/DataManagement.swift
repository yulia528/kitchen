//
//  DataManagement.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/21/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//
typealias JSONDATA = [String: Any]

import Foundation
import UIKit

class DataManagement {
    static let shared = DataManagement()
    var authorizationData = AuthorizationData()
    var kitchenData = KitchenData(categories: createCategoryData(), items: [])
    var userData: UserData? = UserData()

    class func createCategoryData() -> [KitchenCategoryData] {
        var categories = [KitchenCategoryData]()
        categories.append(KitchenCategoryData(id: 1, title: "FRIDGE", badge: "2", image: UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)))
        categories.append(KitchenCategoryData(id: 2, title: "CUPBOARD", badge: nil, image: UIImage(named: "shopping")?.withRenderingMode(.alwaysTemplate)))
        categories.append(KitchenCategoryData(id: 3, title: "FREEZER", badge: nil, image: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate)))
        categories.append(KitchenCategoryData(id: 4, title: "SPICES", badge: "!", image: UIImage(named: "recipe")?.withRenderingMode(.alwaysTemplate)))
        categories.append(KitchenCategoryData(id: 5,title: "BEVERAGES", badge: "10", image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)))
        
        return categories
    }
}





