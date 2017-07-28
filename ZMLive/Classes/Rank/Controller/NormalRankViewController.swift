//
//  NormalRankViewController.swift
//  zhanming
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class NormalRankViewController: SubrankViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubrankUI(["日榜", "周榜", "月榜", "总榜"])
    }
    
}
