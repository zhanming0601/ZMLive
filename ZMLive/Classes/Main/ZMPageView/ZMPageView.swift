//
//  ZMPageView.swift
//  ZMContentPageView
//
//  Created by xiaomage on 2016/10/27.
//  Copyright © 2016年 seemygo. All rights reserved.
//

import UIKit

class ZMPageView: UIView {
    
    // MARK: 定义属性
    fileprivate var titles : [String]!
    fileprivate var style : ZMTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : ZMTitleView!
    fileprivate var contentView : ZMContentView!
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles : [String], style : ZMTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
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
extension ZMPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = style.titleHeight
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = ZMTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = ZMContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}


// MARK:- 设置ZMContentView的代理
extension ZMPageView : ZMContentViewDelegate {
    func contentView(_ contentView: ZMContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: ZMContentView) {
        titleView.contentViewDidEndScroll()
    }
}


// MARK:- 设置ZMTitleView的代理
extension ZMPageView : ZMTitleViewDelegate {
    func titleView(_ titleView: ZMTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
