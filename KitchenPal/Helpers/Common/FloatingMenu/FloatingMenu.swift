//
//  FloatingMenu.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/17/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit
import MaterialComponents

let DURATION_MAIN_BUTTON: Double = 0.3
let DURATION_ITEM_BUTTON: Double = 0.3
let SUB_DELAY_ITEM_BUTTON_ANIMATED: Double = 0.05

let ITEM_SPACE: CGFloat = 14
let MAIN_TO_ITEM_SPACE: CGFloat = 24

let ITEM_BUTTON_SIZE: CGFloat = 42
let MAIN_BUTTON_SIZE: CGFloat = 56

let INK_OPACITY: CGFloat = 0.4

enum ActionStatus: Int {
  case Open, Close
}

protocol FloatingMenuDelegate: class {
  func floatingMenu(_ sender: FloatingMenu, didClose none: Bool)
  func floatingMenu(_ sender: FloatingMenu, didOpen none: Bool)
  func floatingMenu(_ sender: FloatingMenu, didPressItem: UIButton, index: Int)
}

class FloatingMenu: PassEventView {  
  @IBOutlet weak var bottomConstrainBackgroundButton: NSLayoutConstraint!
  weak var delegate: FloatingMenuDelegate?
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var tapGesture: UITapGestureRecognizer!
  @IBOutlet weak var backgroundButton: UIView!
  var routeMainButtonImage: UIImageView = UIImageView(image: UIImage(named: "Plus")?.withRenderingMode(.alwaysTemplate))
  var floatingButton: MDCFloatingButton!
  var buttons: [UIButton] = []
    var items: [FloatingMenuItem] = []
  var actionStatus: ActionStatus = .Close {
    didSet {
      if actionStatus == .Close {
        floatingButton.inkColor = self.mainButtonBackgroundColorOpen.withAlphaComponent(INK_OPACITY)
      } else {
        floatingButton.inkColor = self.mainButtonBackgroundColorClose.withAlphaComponent(INK_OPACITY)
      }
    }
  }
    
  let mainButtonBackgroundColorOpen = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  let mainButtonBackgroundColorClose = AppSetting.shared.color.redmain
  let mainButtonColorOpen = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  let mainButtonColorClose = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static func instance(items: [FloatingMenuItem]) -> FloatingMenu {
        let views = Bundle.main.loadNibNamed("FloatingMenu", owner: self, options: nil)!
        let instance = views[0] as! FloatingMenu
        instance.items = items
        instance.setup()
        return instance
    }
    
  func setup() {
    self.backgroundColor = .clear
    backgroundView.isHidden = true
    addItemButtons(icons:items)    
    addMainButton()
    
  }
  
  func addMainButton() {
    backgroundButton.backgroundColor = .clear
    floatingButton = MDCFloatingButton()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.tintColor = mainButtonColorClose
    floatingButton.backgroundColor = mainButtonBackgroundColorClose
    floatingButton.sizeToFit()
    backgroundButton.addSubview(floatingButton)
    floatingButton.centerXAnchor.constraint(equalTo: backgroundButton.centerXAnchor).isActive = true
    floatingButton.centerYAnchor.constraint(equalTo: backgroundButton.centerYAnchor).isActive = true
    floatingButton.addTarget(self, action: #selector(self.clickButton(_:)), for: .touchUpInside)
    routeMainButtonImage.backgroundColor = .clear
    routeMainButtonImage.tintColor = mainButtonColorClose
    routeMainButtonImage.contentMode = .center
    backgroundButton.addSubview(routeMainButtonImage)
  }
  
  func addItemButtons(icons: [FloatingMenuItem]) {
    for (index, icon) in icons.enumerated() {
      let button = MDCFloatingButton()
      button.frame = CGRect(x: 0, y: 0, width: ITEM_BUTTON_SIZE, height: ITEM_BUTTON_SIZE)
      button.setImage(icon.icon, for: .normal)
      button.layer.cornerRadius = ITEM_BUTTON_SIZE / 2
      button.tintColor = icon.tinColor
      button.inkColor = icon.tinColor.withAlphaComponent(INK_OPACITY)
      self.addSubview(button)
      buttons.append(button)
      button.isHidden = true
      button.backgroundColor = icon.backgroundColor
      button.tag = index
      button.addTarget(self, action: #selector(self.itemButtonPress(_:)), for: .touchUpInside)
    }
  }
  
  @objc
  func itemButtonPress(_ sender: UIButton) {
    delegate?.floatingMenu(self, didPressItem: sender, index: sender.tag)
    clickButton(floatingButton)
  }
  override func layoutSubviews() {
    let midMainPostion = CGPoint(x: backgroundButton.frame.midX, y: backgroundButton.frame.midY)
    for (index, button) in buttons.enumerated() {
      let position = self.positon(centerPoint: midMainPostion, mainToItemSpace: MAIN_TO_ITEM_SPACE, itemSpace: ITEM_SPACE, itemIndex: index)
      button.center = position
    }
    routeMainButtonImage.frame = backgroundButton.bounds
  }
  
  
  @objc
  func clickButton(_ sender: UIButton) {
    if (actionStatus == .Close) {
      backgroundView.alpha = 0
      backgroundView.isHidden = false
      UIView.animate(withDuration: DURATION_MAIN_BUTTON, animations: {
        self.routeMainButtonImage.tintColor = self.mainButtonColorOpen
        self.routeMainButtonImage.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi / 4))
        self.floatingButton.backgroundColor = self.mainButtonBackgroundColorOpen
        self.backgroundView.alpha = 0.3
      }) { (success) in
      
      }
      self.animateButtonOpen()
      actionStatus = .Open
      delegate?.floatingMenu(self, didOpen: true)
    } else {
      UIView.animate(withDuration: DURATION_MAIN_BUTTON, animations: {
        self.routeMainButtonImage.tintColor = self.mainButtonColorClose
        self.routeMainButtonImage.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi / 2))
        self.backgroundView.alpha = 0
        self.floatingButton.backgroundColor = self.mainButtonBackgroundColorClose
      }) { (success) in
        self.routeMainButtonImage.transform = CGAffineTransform.identity
        self.backgroundView.isHidden = true
      }
      self.animateButtonClose()
      actionStatus = .Close
      delegate?.floatingMenu(self, didClose: true)
    }
  }
  
  func animateButtonOpen() {
    floatingButton.isUserInteractionEnabled = false
    let midMainPostion = CGPoint(x: backgroundButton.frame.midX, y: backgroundButton.frame.midY)
    for (index, button) in buttons.enumerated() {
      let position = self.positon(centerPoint: midMainPostion, mainToItemSpace: MAIN_TO_ITEM_SPACE, itemSpace: ITEM_SPACE, itemIndex: index)
      let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
      button.transform =  scale
      button.alpha = 0
      button.isHidden = false
      button.center = position
    }
    for (index, button) in buttons.enumerated() {
      UIView.animate(withDuration: DURATION_ITEM_BUTTON, delay: delayAnimatedButtonItem(itemIndex: index), options: UIView.AnimationOptions.curveEaseInOut, animations: {
        button.transform = CGAffineTransform.identity
        button.alpha = 1
      }) { (success) in
        if index == (self.buttons.count - 1) {
            self.floatingButton.isUserInteractionEnabled = true
        }
      }
    }
  }
  func animateButtonClose() {
    self.floatingButton.isUserInteractionEnabled = false
    var transforms: [CGAffineTransform] = []
    for _ in buttons {
      let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
      transforms.append(scale)
    }
    
    for (index,button) in self.buttons.enumerated() {
      let indexAnimated = self.buttons.count - index - 1
      UIView.animate(withDuration: DURATION_ITEM_BUTTON, delay: delayAnimatedButtonItem(itemIndex: indexAnimated), options: UIView.AnimationOptions.curveEaseInOut, animations: {
        button.transform = transforms[index]
        button.alpha = 0
      }) { (success) in
        button.isHidden = true
        if index == 0 {
          self.floatingButton.isUserInteractionEnabled = true
        }
      }
    }
  }
  
  func close() {
    self.backgroundView.isHidden = true
    for button in buttons {
      button.isHidden = true
    }
    self.floatingButton.backgroundColor = mainButtonBackgroundColorClose
    self.floatingButton.tintColor = mainButtonColorClose
    self.floatingButton.transform = .identity
    self.actionStatus = .Close
  }
  
  func positon(centerPoint: CGPoint, mainToItemSpace: CGFloat, itemSpace: CGFloat, itemIndex: Int) -> CGPoint {
    var point = centerPoint
    point.y -= ((itemSpace + ITEM_BUTTON_SIZE) * CGFloat(itemIndex) + mainToItemSpace + MAIN_BUTTON_SIZE / 2 + ITEM_BUTTON_SIZE / 2)
    return point
  }
  
  func delayAnimatedButtonItem(itemIndex: Int) -> Double {
    return Double(itemIndex) * SUB_DELAY_ITEM_BUTTON_ANIMATED
  }
  
  @IBAction func tapGesture(_ sender: Any) {
    if actionStatus == .Open {
      clickButton(floatingButton)
    }
  }
}

struct FloatingMenuItem {
  var icon: UIImage
  var tinColor: UIColor
  var backgroundColor: UIColor
  init(icon: UIImage) {
    self.icon = icon
    self.tinColor = .white
    self.backgroundColor = .lightGray
  }
  
  init(icon: UIImage, tinColor: UIColor, backgroundColor: UIColor) {
    self.icon = icon
    self.tinColor = tinColor
    self.backgroundColor = backgroundColor
  }
}
