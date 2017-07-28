//
//  HYGiftChannelView.swift
//  GiftAnim
//
//  Created by apple on 17/6/20.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

private let kShowChannelDuration : TimeInterval = 0.25
private let kHiddenChannelDelay : TimeInterval = 3

enum HYGiftChannelState {
    case idle
    case animating
    case animated
}

protocol HYGiftChannelViewDelegate : class {
    func giftAnimationDidCompletion()
}

class HYGiftChannelView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: HYDigitLabel!
    
    // MARK: 内部属性
    fileprivate var numOfCache : Int = 0
    fileprivate var currentNumber : Int = 0
    
    // MARK: 对外属性
    weak var delegate : HYGiftChannelViewDelegate?
    var state : HYGiftChannelState = .idle
    var giftModel : HYGiftModel? {
        didSet {
            guard let giftModel = giftModel else { return }
            iconImageView.image = UIImage(named: giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物：【\(giftModel.giftName)】"
            giftImageView.setImage(giftModel.giftURL)
        }
    }
}


// MARK:- 设置UI界面
extension HYGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}


// MARK:- 对外提供函数
extension HYGiftChannelView {
    class func loadChannelView() -> HYGiftChannelView {
        return Bundle.main.loadNibNamed("HYGiftChannelView", owner: nil, options: nil)?.first as! HYGiftChannelView
    }
    
    func addOnceGiftAnimToCache() {
        if state == .animating {
            numOfCache += 1
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            performDigitAnim()
        }
    }
    
    func performAnimation() {
        // 0.改变状态
        state = .animating
        
        // 1.弹出ChannelView
        UIView.animate(withDuration: kShowChannelDuration, animations: {
            self.frame.origin.x = 0
            self.alpha = 1.0
        }, completion: { (isFinished : Bool) in
            self.performDigitAnim()
        })
    }
}

extension HYGiftChannelView {
    fileprivate func performDigitAnim() {
        digitLabel.alpha = 1.0
        currentNumber += 1
        digitLabel.text = " x\(currentNumber) "
        
        digitLabel.startAnimation(kShowChannelDuration, {
            if self.numOfCache > 0 {
                self.numOfCache -= 1
                self.performDigitAnim()
            } else {
                self.state = .animated
                self.perform(#selector(self.endAnimation), with: nil, afterDelay: kHiddenChannelDelay)
            }
        })
    }
    
    @objc fileprivate func endAnimation() {
        state = .idle
        
        UIView.animate(withDuration: kShowChannelDuration, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
        }, completion: { (isFinished : Bool) in
            self.giftModel = nil
            self.digitLabel.alpha = 0.0
            self.frame.origin.x = -self.frame.width
            self.currentNumber = 0
            
            // 告知父控件已经结束了动画
            self.delegate?.giftAnimationDidCompletion()
        })
    }
}
