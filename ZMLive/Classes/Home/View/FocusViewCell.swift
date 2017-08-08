//
//  FocusViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/21.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class FocusViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var liveImageView: UIImageView!
    
    var anchorModel : AnchorModel? {
        didSet {
            iconImageView.setImage(anchorModel?.pic51)
            nickNameLabel.text = anchorModel?.name
        }
    }
}
