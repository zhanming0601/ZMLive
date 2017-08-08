//
//  HYGiftContainerView.swift
//  GiftAnim
//
//  Created by apple on 17/6/20.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class HYGiftContainerView: UIView {
    
    // MARK: 内部属性
    fileprivate lazy var channelViews : [HYGiftChannelView] = [HYGiftChannelView]()
    fileprivate lazy var giftCaches : [HYGiftModel] = [HYGiftModel]()
    
    // MARK: 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension HYGiftContainerView {
    fileprivate func setupUI() {
        // 1.根据当前的渠道数，创建HYGiftChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
            let channelView = HYGiftChannelView.loadChannelView()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            channelView.delegate = self
            addSubview(channelView)
            channelViews.append(channelView)
        }
    }
}


// MARK:- 对外提供函数
extension HYGiftContainerView {
    func insertGiftModel(_ giftModel : HYGiftModel) {
        // 1.判断是否有相同的ChannelView在执行动画
        if let channelView = checkChannelForSameGiftModel(giftModel) {
            channelView.addOnceGiftAnimToCache()
            return
        }
        
        // 2.判断是否有闲置的ChanelView可以用于执行动画
        if let channelView = checkChannelOfIdle() {
            channelView.giftModel = giftModel
            channelView.performAnimation()
            return
        }
        
        // 3.放到缓存中，等待闲置后执行
        giftCaches.append(giftModel)
    }
}


// MARK:- 私有函数
extension HYGiftContainerView {
    
    /// 检测是否有giftModel处于正在执行动画
    fileprivate func checkChannelForSameGiftModel(_ giftModel : HYGiftModel) -> HYGiftChannelView? {
        for channel in channelViews {
            if let channelGift = channel.giftModel {
                if channelGift.isEqual(giftModel) {
                    return channel
                }
            }
        }
        return nil
    }
    
    
    /// 检测是否有闲置的ChannelView用于处理动画
    fileprivate func checkChannelOfIdle() -> HYGiftChannelView? {
        for channel in channelViews {
            if channel.state == .idle {
                return channel
            }
        }
        
        return nil
    }
}



// MARK:- 监听动画执行完成
extension HYGiftContainerView : HYGiftChannelViewDelegate {
    func giftAnimationDidCompletion() {
        if giftCaches.count > 0 {
            let giftModel = giftCaches.first!
            giftCaches.removeFirst()
            insertGiftModel(giftModel)
        }
    }
}
