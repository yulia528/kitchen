//
//  AppSetting.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/24/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation
import UIKit

class AppSetting {
    static var shared: AppSetting = {
        let appSetting = AppSetting()
        return appSetting
    }()
    let language = AppLanguage()
    let color = AppColor()
    private init() {
        //todo
    }
}

struct AppColor {
    let redmain = #colorLiteral(red: 0.8640050292, green: 0.2652097344, blue: 0.2167421281, alpha: 1)
}

struct AppLanguage {
    let languageCode: String = Locale.current.languageCode ?? "en"
    let localizeCode: String = Locale.current.identifier
}

extension AppLanguage {
    var httpHeader: [String: String] {
        return [
            "lan": languageCode
        ]
    }
}
