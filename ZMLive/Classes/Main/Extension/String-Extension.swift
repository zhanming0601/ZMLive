//
//  String-Extension.swift
//  zhanming
//
//  Created by apple on 17/6/15.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import Foundation

extension String {
    static var documentPath : String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
}
