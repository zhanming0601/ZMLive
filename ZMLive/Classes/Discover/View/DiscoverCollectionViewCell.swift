//
//  DiscoverCollectionViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    
    var anchor : AnchorModel?  {
        didSet {
            guard let anchor = anchor else { return }
            
            onlineLabel.text = "\(anchor.focus)人观看"
            nickNameLabel.text = anchor.name
            iconImageView.setImage(anchor.pic51, "home_pic_default")
            liveImageView.isHidden = anchor.live == 0
        }
    }
}
