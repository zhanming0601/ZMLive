//
//  CarouselView.swift
//  zhanming
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

private let kCarouselViewCellID = "kCarouselViewCellID"

class CarouselView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate lazy var carouselVM : CarouselViewModel = CarouselViewModel()
    fileprivate var updateTimer : Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CarouselViewCell.self, forCellWithReuseIdentifier: kCarouselViewCellID)
        
        addTimer()
        
        carouselVM.loadCarouselData {
            self.collectionView.reloadData()
            
            self.pageControl.numberOfPages = self.carouselVM.carousels.count
            
            let startIndexPath = IndexPath(item: self.carouselVM.carousels.count * 100, section: 0)
            self.collectionView.scrollToItem(at: startIndexPath, at: .left, animated: false)
        }
    }
}

extension CarouselView {
    class func loadCarouseView() -> CarouselView {
        return Bundle.main.loadNibNamed("CarouselView", owner: nil, options: nil)?.first as! CarouselView
    }
}


extension CarouselView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselVM.carousels.count * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCarouselViewCellID, for: indexPath) as! CarouselViewCell
        
        cell.carouselModel = carouselVM.carousels[indexPath.item % carouselVM.carousels.count]
        
        return cell
    }
}


class CarouseViewLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = collectionView!.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}

// MARK:- 定时器操作方法
extension CarouselView {
    fileprivate func addTimer() {
        updateTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(updateTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    @objc private func scrollToNext() {
        let offset = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}


class CarouselViewCell : UICollectionViewCell {
    
    var carouselModel : CarouselModel? {
        didSet {
            imageView.setImage(carouselModel?.picUrl, "Img_default")
        }
    }
    
    fileprivate lazy var imageView : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
}



extension CarouselView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.滚动的距离
        let offsetX = scrollView.contentOffset.x
        
        // 2.设置pageControl
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % 4
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }

}
