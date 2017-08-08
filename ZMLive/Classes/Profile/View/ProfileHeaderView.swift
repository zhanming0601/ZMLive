//
//  ProfileHeaderView.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
}

extension ProfileHeaderView {
    class func loadProfileView() -> ProfileHeaderView {
        return Bundle.main.loadNibNamed("ProfileHeaderView", owner: nil, options: nil)?.first as! ProfileHeaderView
    }
}
