//
//  UIImage-Extension.swift
//  zhanming
//
//  Created by apple on 17/6/8.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(_ color : UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 200.0, height: 32.0)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(3.0)
        context?.addEllipse(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
