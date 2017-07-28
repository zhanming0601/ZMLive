//
//  BaseModel.swift
//  zhanming
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
