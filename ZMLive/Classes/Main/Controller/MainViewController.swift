//
//  MainViewController.swift
//  zhanming
//
//  Created by apple on 17/6/8.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Rank")
        addChildVc("Discover")
        addChildVc("Profile")
    }
    
    fileprivate func addChildVc(_ storyName : String) {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }
}
