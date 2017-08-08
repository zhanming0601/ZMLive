//
//  GiftViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class GiftViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var giftModel : GiftModel? {
        didSet {
            iconImageView.setImage(giftModel?.img2, "room_btn_gift")
            subjectLabel.text = giftModel?.subject
            priceLabel.text = "\(giftModel?.coin ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView()
        selectedView.layer.cornerRadius = 5
        selectedView.layer.masksToBounds = true
        selectedView.layer.borderWidth = 1
        selectedView.layer.borderColor = UIColor.orange.cgColor
        selectedView.backgroundColor = UIColor.black
        selectedBackgroundView = selectedView
    }
}
