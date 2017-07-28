//
//  ProfileViewCell.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    @IBOutlet weak var contentLabelLeftCons: NSLayoutConstraint!
    
    var itemModel : SettingsItemModel? {
        didSet {
            // 1.校验模型是否有值
            guard let itemModel = itemModel else {
                return
            }
            
            // 2.校验是否有图片
            itemModel.iconName == "" ? (iconImageView.isHidden = true) : (iconImageView.image = UIImage(named: itemModel.iconName))
            
            
            contentLabelLeftCons.constant = itemModel.iconName == "" ? -30 : 10
            
            // 3.设置内容
            contentLabel.text = itemModel.contentText
            
            // 4.箭头是否显示
            switch itemModel.accessoryType {
            case .arrow:
                onSwitch.isHidden = true
                hintLabel.isHidden = true
            case .arrowHint:
                onSwitch.isHidden = true
                hintLabel.isHidden = false
                hintLabel.text = itemModel.hintText
            case .onswitch:
                onSwitch.isHidden = false
                hintLabel.isHidden = true
                arrowImageView.isHidden = true
            }
        }
    }
}
