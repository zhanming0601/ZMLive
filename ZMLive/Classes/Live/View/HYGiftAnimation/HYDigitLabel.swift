//
//  HYDigitLabel.swift
//  GiftAnim
//
//  Created by apple on 17/6/20.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class HYDigitLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        // 0.保存文本颜色
        let oldColor = textColor
        
        // 1.获取上下文
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(5)
        context?.setLineJoin(.round)
        
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.yellow
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = oldColor
        shadowOffset = CGSize.zero
        
        super.drawText(in: rect)
    }
    
    func startAnimation(_ duration : TimeInterval, _ finished : @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }, completion: { isFinished in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (isFinished) in
                finished()
            })
        })
    }
}
