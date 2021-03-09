//
//  Localized.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/24/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation

extension String {
    func localized(comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
