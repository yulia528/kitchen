//
//  StoryBoard.swift
//  APP
//
//  Created by Nha Duong on 2/18/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//
import UIKit
import Foundation

enum StoryBoardName: String {
    case Main
    case Kitchen
    
    func storyboard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
}

extension UIStoryboard {
    func instance<T: UIViewController>(type: T.Type) -> T? {
        let identifier = T.typeName
        return self.instantiateViewController(withIdentifier: identifier) as? T
    }
}
