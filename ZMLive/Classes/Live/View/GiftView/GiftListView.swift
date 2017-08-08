//
//  GiftListView.swift
//  zhanming
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"

protocol GiftListViewDelegate : class {
    func giftListView(giftView : GiftListView, giftModel : GiftModel)
}

class GiftListView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    fileprivate var pageCollectionView : ZMPageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
    
    weak var delegate : GiftListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1.初始化礼物的View
        setupGiftView()
        
        // 2.加载礼物的数据
        loadGiftData()
    }
}

extension GiftListView {
    fileprivate func setupUI() {
        setupGiftView()
    }
    
    fileprivate func setupGiftView() {
        let style = ZMTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = ZMContentFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = kScreenW
        pageCollectionView = ZMPageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], style: style, isTitleInTop: true, layout : layout)
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.regist(nib: UINib(nibName: "GiftViewCell", bundle: nil), forCellID: kGiftCellID)
    }
}


// MARK:- 加载数据
extension GiftListView {
    fileprivate func loadGiftData() {
        GiftViewModel.shareInstance.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}


// MARK:- 快速创建的类方法
extension GiftListView {
    class func loadGiftListView() -> GiftListView {
        return Bundle.main.loadNibNamed("GiftListView", owner: nil, options: nil)?.first as! GiftListView
    }
}


// MARK:- 数据设置
extension GiftListView : ZMPageCollectionViewDataSource, ZMPageCollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GiftViewModel.shareInstance.giftlistData.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, numsOfItemsInSection section: Int) -> Int {
        let package = GiftViewModel.shareInstance.giftlistData[section]
        return package.list.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        
        let package = GiftViewModel.shareInstance.giftlistData[indexPath.section]
        cell.giftModel = package.list[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, didSelected atIndexPath: IndexPath) {
        currentIndexPath = atIndexPath
        sendGiftBtn.isEnabled = true
    }
}


// MARK:- 送礼物
extension GiftListView {
    @IBAction func sendGiftBtnClick() {
        let package = GiftViewModel.shareInstance.giftlistData[currentIndexPath!.section]
        let giftModel = package.list[currentIndexPath!.item]
        delegate?.giftListView(giftView: self, giftModel: giftModel)
    }
}
