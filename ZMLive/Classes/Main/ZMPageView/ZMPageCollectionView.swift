//
//  ZMPageCollectionView.swift
//  ZMPageCollectionView
//
//  Created by apple on 17/6/11.
//  Copyright © 2017年 coderwZM. All rights reserved.
//

import UIKit


protocol ZMPageCollectionViewDataSource : class {
    func numberOfSections(in collectionView : UICollectionView) -> Int
    func pageCollectionView(_ collectionView : UICollectionView, numsOfItemsInSection section : Int) -> Int
    func pageCollectionView(_ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell
}

@objc protocol ZMPageCollectionViewDelegate : class {
    @objc optional func pageCollectionView(_ collectionView : UICollectionView, didSelected atIndexPath : IndexPath)
}

class ZMPageCollectionView: UIView {
    
    // MARK: 对外属性
    weak var dataSource : ZMPageCollectionViewDataSource?
    weak var delegate : ZMPageCollectionViewDelegate?
    
    // MARK: 内部属性
    fileprivate var titles : [String]
    fileprivate var style : ZMTitleStyle
    fileprivate var isTitleInTop : Bool = false
    fileprivate var layout : ZMContentFlowLayout
    
    fileprivate var titleView : ZMTitleView!
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect, titles : [String], style : ZMTitleStyle, isTitleInTop : Bool, layout : ZMContentFlowLayout) {
        
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ZMPageCollectionView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        var titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleFrame.origin.y = isTitleInTop ? 0 : frame.height - titleH
        titleView = ZMTitleView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        titleView.delegate = self
        
        let pageControlH : CGFloat = 20
        var pageControlFrame = CGRect(x: 0, y: 0, width: frame.width, height: pageControlH)
        pageControlFrame.origin.y = isTitleInTop ? frame.height - pageControlH : frame.height - titleH - pageControlH
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        addSubview(pageControl)
        
        var collectionViewFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - titleH - pageControlH)
        collectionViewFrame.origin.y = isTitleInTop ? titleFrame.maxY : 0
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        addSubview(collectionView)
    }
    
}

extension ZMPageCollectionView {
    func register(cellClass : AnyClass?, forCellID : String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: forCellID)
    }
    
    func regist(nib : UINib?, forCellID : String) {
        collectionView.register(nib, forCellWithReuseIdentifier: forCellID)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension ZMPageCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: section) ?? 0
        
        if section == 0 {
            let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
            pageControl.numberOfPages = numOfPage
        }
        
        return numOfSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(collectionView, cellForItemAt: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView?(collectionView, didSelected: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll()
        }
    }
    
    func collectionViewDidEndScroll() {
        
        // 获取该页第一个Cell
        let offsetX = collectionView.contentOffset.x
        let targetIndex = collectionView.indexPathForItem(at: CGPoint(x: offsetX + layout.sectionInset.left + 1, y: layout.sectionInset.top + 1))!
        
        pageControl.currentPage = (targetIndex.item) / (layout.cols * layout.rows)
        
        // 判断section发生改变
        if sourceIndexPath.section != targetIndex.section {
            titleView.setTitleWithProgress(1.0, sourceIndex: sourceIndexPath.section, targetIndex: targetIndex.section)
            
            sourceIndexPath = targetIndex
            
            let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: targetIndex.section) ?? 0
            let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
            pageControl.numberOfPages = numOfPage
        }
        
    }
}


extension ZMPageCollectionView : ZMTitleViewDelegate {
    func titleView(_ titleView: ZMTitleView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: indexPath.section) ?? 0
        let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
        pageControl.numberOfPages = numOfPage
        pageControl.currentPage = 0
        
        sourceIndexPath = indexPath
    }
}
