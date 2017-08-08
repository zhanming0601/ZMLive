//
//  UITextField-Extension.swift
//  zhanming
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

extension UITextField {
    func selectedRange() -> NSRange {
        let begin = beginningOfDocument
        let textRange = selectedTextRange!
        
        let start = textRange.start
        let end = textRange.end
        
        let location = offset(from: begin, to: start)
        let length = offset(from: start, to: end)
        
        return NSMakeRange(location, length)
    }
}
