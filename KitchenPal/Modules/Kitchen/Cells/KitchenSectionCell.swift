//
//  KitchenSectionCell.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/14/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents
class KitchenSectionCell: MDCCardCollectionCell {
  
  @IBOutlet weak var titleLabel: UILabel!
@IBOutlet weak var imageView: UIImageView!
    
  var item: KitchenItemData! {
    didSet {
      titleLabel.text = item.name
      imageView.sd_setImage(with: URL(string: item.defaultImage ?? ""), placeholderImage: UIImage(named: "default-image"))
      self.layer.masksToBounds = false
      self.layer.cornerRadius = 5
    }
  }
  
}
