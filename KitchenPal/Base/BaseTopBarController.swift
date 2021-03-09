//
//  BaseTopBarController.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/25/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit

class BaseTopBarController: UINavigationController,BottomBarControllerItem {
    weak var bottomBarController: BottomBarController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let vc = viewController as? BaseViewController {
            vc.bottomBarController = self.bottomBarController
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        for viewController in viewControllers {
            if let vc = viewController as? BaseViewController {
                vc.bottomBarController = self.bottomBarController
            }
        }
        
        super.setViewControllers(viewControllers, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
