//
//  DiscoverContentViewModel.swift
//  zhanming
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class DiscoverContentViewModel : HomeViewModel {
    
}

extension DiscoverContentViewModel {
    func loadContentData(_ complection : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://qf.56.com/home/v4/guess.ios", parameters: ["count" : 27], finishedCallback: { (result : Any) in
            // 1.转成字典
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.取出内容
            guard let msgDict = resultDict["message"] as? [String : Any] else { return }
            
            // 3.取出内容
            guard let dataArray = msgDict["anchors"] as? [[String : Any]] else { return }
            
            // 4.转成模型对象
            for dict in dataArray {
                self.anchorModels.append(AnchorModel(dict: dict))
            }
            
            // 5.回调
            complection()
        })
    }
}
