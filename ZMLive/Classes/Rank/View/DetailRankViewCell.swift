//
//  DetailRankViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class DetailRankViewCell: UITableViewCell {
    
    @IBOutlet weak var rankNumBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var liveImageView: UIImageView!
    
    var rankNum : Int = 0 {
        didSet {
            if rankNum < 3 {
                rankNumBtn.setTitle("", for: .normal)
                rankNumBtn.setImage(UIImage(named: "ranking_icon_no\(rankNum + 1)"), for: .normal)
            } else {
                rankNumBtn.setImage(nil, for: .normal)
                rankNumBtn.setTitle("\(rankNum + 1)", for: .normal)
            }
        }
    }
    
    var rankModel : RankModel? {
        didSet {
            iconImageView.setImage(rankModel?.avatar)
            nickNameLabel.text = rankModel?.nickname
            liveImageView.isHidden = rankModel?.isInLive == 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.layer.masksToBounds = true
    }
}
