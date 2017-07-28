//
//  EmoticonViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    var emoticon : Emoticon? {
        didSet {
            iconImageView.image = UIImage(named: emoticon!.emoticonName)
        }
    }
}
