//
//  TabBarController.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/20/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit
import  MaterialComponents

class BottomBarController: UIViewController {
    var viewControllers: [UIViewController] = [
        StoryBoardName.Kitchen.storyboard().instance(type: KitchenVC.self)!,
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController()
    ]
    var currentViewController: UIViewController?
    var selectedIndex: Int = 0
    let bottomNavBar = MDCBottomNavigationBar()
    var floatingMenu: FloatingMenu!


    var tabBarItems: [TabBarItem] = [
        TabBarItem(title: "Kitchen", image:UIImage(named: "Home")!),
        TabBarItem(title: "Shopping", image: UIImage(named: "Email")!),
        TabBarItem(title: "Recipes", image: UIImage(named: "Favorite")!),
        TabBarItem(title: "Profile", image: UIImage(named: "Cake")!),
    ]

    var floatingMenuItems: [FloatingMenuItem] = [
        FloatingMenuItem(icon: UIImage(named: "Home")!.withRenderingMode(.alwaysTemplate), tinColor: .gray, backgroundColor: .white),
        FloatingMenuItem(icon: UIImage(named: "Email")!.withRenderingMode(.alwaysTemplate), tinColor: .gray, backgroundColor: .white),
        FloatingMenuItem(icon: UIImage(named: "Favorite")!.withRenderingMode(.alwaysTemplate), tinColor: .gray, backgroundColor: .white),
        FloatingMenuItem(icon: UIImage(named: "Cake")!.withRenderingMode(.alwaysTemplate), tinColor: .gray, backgroundColor: .white)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
       setupTabBarItems(tabBarItems: tabBarItems)
        setupFloatingMenu(floatingMenuItems: floatingMenuItems)
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContentViewController(content: viewControllers[selectedIndex])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addFloatingMenu(bottomMargin: bottomNavBar.frame.height + 8)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    func setupTabBarItems(tabBarItems: [TabBarItem]) {
        bottomNavBar.sizeThatFitsIncludesSafeArea = true
        view.addSubview(bottomNavBar)
        bottomNavBar.delegate = self
        bottomNavBar.titleVisibility = .always
        var tabbarUIItems = [UITabBarItem]()
        for (index, item) in tabBarItems.enumerated() {
          let uiItem = UITabBarItem(title: item.title, image: item.image, tag: index)
          uiItem.badgeValue = item.badge
          tabbarUIItems.append(uiItem)
        }
        bottomNavBar.items = tabbarUIItems
        bottomNavBar.selectedItem = tabbarUIItems[selectedIndex]
        bottomNavBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        bottomNavBar.selectedItemTintColor = AppSetting.shared.color.redmain
        bottomNavBar.unselectedItemTintColor = #colorLiteral(red: 0.4470072985, green: 0.44708848, blue: 0.4470021725, alpha: 1)
    }
    
    func setupFloatingMenu(floatingMenuItems: [FloatingMenuItem]) {
        floatingMenu = FloatingMenu.instance(items: floatingMenuItems)
    }
    
    func layoutBottomNavBar() {
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        var bottomNavBarFrame = CGRect(x: 0,
                                       y: view.bounds.height - size.height,
                                       width: size.width,
                                       height: size.height)
        // Extend the Bottom Navigation to the bottom of the screen.
        if #available(iOS 11.0, *) {
          bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
          bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
        }
        bottomNavBar.frame = bottomNavBarFrame
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        let bottomNavBarFrame = CGRect(x: 0,
                                       y: view.bounds.height - size.height,
                                       width: size.width,
                                       height: size.height)
        bottomNavBar.frame = bottomNavBarFrame
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
    func addContentViewController(content: UIViewController) {
        let lastContentVC = currentViewController
        self.addChild(content)
        self.view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        content.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        content.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        content.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomNavBar.sizeThatFits(view.bounds.size).height).isActive = true
        currentViewController = content
        removeContentViewController(content: lastContentVC)
        view.bringSubviewToFront(bottomNavBar)
        self.bringFloatingMenuToTop()
    }
  
    func removeContentViewController(content: UIViewController?) {
        if let content = content {
          content.view.removeFromSuperview()
          content.removeFromParent()
        }
    }
    
    func willChangeToIndex(tabIndex: Int) {
        if tabIndex == 0 {
            self.addFloatingMenu(bottomMargin: bottomNavBar.frame.height + 8)
        }
    }
    
    func didChangeToIndex(tabIndex: Int) {
        if tabIndex != 0 {
            self.removeFloatingMenu()
        }
    }

}

extension BottomBarController: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        if let index = bottomNavigationBar.items.firstIndex(of: item), index != selectedIndex {
            self.willChangeToIndex(tabIndex: index)
            self.selectedIndex = index
            self.addContentViewController(content: viewControllers[self.selectedIndex])
            bottomNavBar.selectedItem = item
            self.didChangeToIndex(tabIndex: index)
        }
    }

    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
        return true
    }
}

extension BottomBarController {
    func addFloatingMenu(bottomMargin: CGFloat =  8) {
        floatingMenu.bottomConstrainBackgroundButton.constant = bottomMargin
        floatingMenu.frame = view.bounds
        floatingMenu.alpha = 0
        floatingMenu.close()
        view.addSubview(floatingMenu)
        floatingMenu.translatesAutoresizingMaskIntoConstraints = false
        floatingMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        floatingMenu.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        floatingMenu.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        floatingMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        floatingMenu.layoutSubviews()
        UIView.animate(withDuration: 0.2) {
            self.floatingMenu.alpha = 1
        }
    }
    
    func removeFloatingMenu() {
        UIView.animate(withDuration: 0.2, animations: {
            self.floatingMenu.alpha = 0
        }) { (success) in
            self.floatingMenu.removeFromSuperview()
        }
    }
    
    
    func bringFloatingMenuToTop() {
        if floatingMenu.superview != nil {
            self.view.bringSubviewToFront(floatingMenu)
        }
    }
}


class TabBarItem {
    var title: String
    var image: UIImage?
    var badge: String?

    init(title: String, image: UIImage?, badge: String? = nil) {
        self.title = title
        self.image = image
        self.badge = badge
    }
}
