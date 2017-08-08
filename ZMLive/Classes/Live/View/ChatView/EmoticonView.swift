//
//  EmoticonView.swift
//  zhanming
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kEmoticonCellID = "kEmoticonCellID"

class EmoticonView: UIView {
    
    fileprivate var pageCollectionView : ZMPageCollectionView!
    
    fileprivate var emoticonClickCallback : (_ emoticon : Emoticon) -> ()
    
    init(frame: CGRect, emoticonClickCallback : @escaping (_ emoticon : Emoticon) -> ()) {
        self.emoticonClickCallback = emoticonClickCallback
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EmoticonView {
    fileprivate func setupUI() {
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        
        let titles = ["普通", "粉丝专属"]
        
        let style = ZMTitleStyle()
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        style.isScrollEnable = false
        style.isShowBottomLine = true
        
        let layout = ZMContentFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.cols = 7
        layout.rows = 3
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        pageCollectionView = ZMPageCollectionView(frame: bounds, titles: titles, style: style, isTitleInTop: false, layout: layout)
        addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.regist(nib: UINib(nibName: "EmoticonViewCell", bundle: nil), forCellID: kEmoticonCellID)
    }
}


extension EmoticonView : ZMPageCollectionViewDataSource, ZMPageCollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EmoticonViewModel.shareInstance.packages.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, numsOfItemsInSection section: Int) -> Int {
        let package = EmoticonViewModel.shareInstance.packages[section]
        
        return package.emoticons.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCellID, for: indexPath) as! EmoticonViewCell
        
        let package = EmoticonViewModel.shareInstance.packages[indexPath.section]
        cell.emoticon = package.emoticons[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, didSelected atIndexPath: IndexPath) {
        let package = EmoticonViewModel.shareInstance.packages[atIndexPath.section]
        let emoticon = package.emoticons[atIndexPath.item]
        emoticonClickCallback(emoticon)
    }
}
