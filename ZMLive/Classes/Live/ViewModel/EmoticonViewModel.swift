//
//  EmoticonViewModel.swift
//  zhanming
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class EmoticonViewModel {
    
    static let shareInstance : EmoticonViewModel = EmoticonViewModel()
    lazy var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        packages.append(EmoticonPackage(plistName: "QHNormalEmotionSort.plist"))
        packages.append(EmoticonPackage(plistName: "QHSohuGifSort.plist"))
    }
}
