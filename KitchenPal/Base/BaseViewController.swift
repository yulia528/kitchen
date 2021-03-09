//
//  BaseViewController.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/25/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit
import MaterialComponents

class BaseViewController: UIViewController, BottomBarControllerItem {
    weak var bottomBarController: BottomBarController?
    var topBar: MDCAppBarViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topBar_ = setupTopBar() {
            addTopBar(topBar: topBar_)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let topBar = topBar {
            view.bringSubviewToFront(topBar.view)
        }
    }
    
    private func addTopBar(topBar: MDCAppBarViewController) {
        self.topBar = topBar
        self.addChild(topBar)
        self.view.addSubview(topBar.view)
        topBar.didMove(toParent: self)
    }
    
    func setupTopBar() -> MDCAppBarViewController? {
        // for override
        return nil
    }

    func setupTopBarDefault() -> MDCAppBarViewController {
        let appBarViewController = MDCAppBarViewController()
        
        appBarViewController.navigationBar.titleAlignment = .leading
        appBarViewController.headerView.backgroundColor = AppSetting.shared.color.redmain
        appBarViewController.headerView.tintColor = .white
        appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
        appBarViewController.headerView.minimumHeight = 56
        
        let layer = appBarViewController.view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        
        return appBarViewController
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
