//
//  HYPageView.swift
//  HYContentPageView
//
//  Created by xiaomage on 2016/10/27.
//  Copyright © 2016年 seemygo. All rights reserved.
//

import UIKit

class HYPageView: UIView {
    
    // MARK: 定义属性
    fileprivate var titles : [String]!
    fileprivate var style : HYTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : HYTitleView!
    fileprivate var contentView : HYContentView!
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles : [String], style : HYTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
        assert(titles.count == childVcs.count, "标题&控制器个数不同,请检测!!!")
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置界面内容
extension HYPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = style.titleHeight
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = HYTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = HYContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}


// MARK:- 设置HYContentView的代理
extension HYPageView : HYContentViewDelegate {
    func contentView(_ contentView: HYContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: HYContentView) {
        titleView.contentViewDidEndScroll()
    }
}


// MARK:- 设置HYTitleView的代理
extension HYPageView : HYTitleViewDelegate {
    func titleView(_ titleView: HYTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
