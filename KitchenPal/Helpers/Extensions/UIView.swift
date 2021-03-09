//
//  UIView.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/20/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit

extension UIView {
  
  func view<T>(with type: T.Type) -> T? {
    if self.isKind(of: type as! AnyClass) {
      return self as! T
    }
    
    for sv in subviews {
      if let view = sv.view(with: type) {
        return view
      }
    }
    
    return nil
  }
}
