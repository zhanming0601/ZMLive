//
//  SocialShareView.swift
//  zhanming
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class SocialShareView: UIView {
    @IBOutlet var shareBtns: [MoreInfoButton]!
    
    @IBAction func shareBtnClick(_ sender: MoreInfoButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "abcd"
    }
}

extension SocialShareView {
    class func loadSocialShareView() -> SocialShareView {
        return Bundle.main.loadNibNamed("SocialShareView", owner: nil, options: nil)?.first as! SocialShareView
    }
    
    func showShareView() {
        // 1.改变btn的位置
        for btn in shareBtns {
            btn.transform = CGAffineTransform(translationX: 0, y: 200)
        }
        
        // 2.恢复位置
        for (index, btn) in shareBtns.enumerated() {
            UIView.animate(withDuration: 0.5, delay: 0.25 + Double(index) * 0.02, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
                btn.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}


