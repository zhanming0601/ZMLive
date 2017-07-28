//
//  MoreInfoView.swift
//  zhanming
//
//  Created by apple on 17/6/11.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class MoreInfoView: UIView {
}

extension MoreInfoView {
    class func loadMoreInfoView() -> MoreInfoView {
        return Bundle.main.loadNibNamed("MoreInfoView", owner: nil, options: nil)?.last as! MoreInfoView
    }
}
