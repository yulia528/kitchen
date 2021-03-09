//
//  LoadingViewController.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/21/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
  
  func loadData() {
    API.shared.kitchenContent(param: [:]) { (resonse) in
        if let data = resonse.result?["data"] as? [JSONDATA] {
            
            let datajson = try? JSONSerialization.data(withJSONObject: data[0], options: .prettyPrinted)
            if let datajson = datajson, let string = String(data: datajson, encoding: String.Encoding.utf8) {
                print(string);
            }
            DataManagement.shared.kitchenData.update(items: KitchenItemData.objects(with: data))
        }
      self.completeLoading()
    }
  }
  
  func completeLoading() {
    AppDelegate.shared?.window?.rootViewController = BottomBarController()
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
