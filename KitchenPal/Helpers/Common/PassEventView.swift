//
//  PassEventView.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/18/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit

class PassEventView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    return view == self ? nil : view
  }
}
