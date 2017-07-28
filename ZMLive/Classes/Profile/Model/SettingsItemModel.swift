//
//  SettingsItemModel.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

enum SettingAccessoryType {
    case arrow
    case arrowHint
    case onswitch
}

class SettingsItemModel {
    var iconName : String = ""
    var contentText : String = ""
    
    var hintText : String = ""
    var accessoryType : SettingAccessoryType = .arrow
    
    init(icon : String = "", content : String, hint : String = "", type : SettingAccessoryType = .arrow) {
        self.iconName = icon
        self.contentText = content
        self.hintText = hint
        self.accessoryType = type
    }
}
