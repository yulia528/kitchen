//
//  KitchenData.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/21/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation
import UIKit


class KitchenData {
    var categories: [KitchenCategoryData]
    var groupItems: [[KitchenItemData]]
    init(categories: [KitchenCategoryData], items: [KitchenItemData]) {
        self.categories = categories
        self.groupItems = []
        for category in categories {
            var itemsByCategory = [KitchenItemData]()
            for item in items {
                if item.defaultStorageId == category.id {
                    itemsByCategory.append(item)
                }
            }
            groupItems.append(itemsByCategory)
        }
    }
    
    func update(items: [KitchenItemData]) {
        var newGroupItems = [[KitchenItemData]]()
        for category in categories {
            var itemsByCategory = [KitchenItemData]()
            for item in items {
                if item.defaultStorageId == category.id {
                    itemsByCategory.append(item)
                }
            }
            newGroupItems.append(itemsByCategory)
        }
        groupItems = newGroupItems
    }
}


struct KitchenCategoryData {
    let id: Int
    let title: String
    var badge: String?
    let image: UIImage?
}


