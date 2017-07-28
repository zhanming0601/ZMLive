//
//  DetailRankViewModel.swift
//  zhanming
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class DetailRankViewModel: NSObject {
    lazy var rankModels : [RankModel] = [RankModel]()
}

extension DetailRankViewModel {
    func loadDetailRankData(_ type : RankType, _ complection : @escaping () -> ()) {
        let URLString = "http://qf.56.com/rank/v1/\(type.typeName).ios"
        let parameters = ["pageSize" : 30, "type" : type.typeNum]
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters, finishedCallback: { result in
            // 1.转成字典
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.取出内容
            guard let msgDict = resultDict["message"] as? [String : Any] else { return }
            
            // 3.取出内容
            guard let dataArray = msgDict[type.typeName] as? [[String : Any]] else { return }
            
            // 4.转成模型对象
            for dict in dataArray {
                self.rankModels.append(RankModel(dict: dict))
            }
            
            // 5.回调
            complection()
        })
    }
}
