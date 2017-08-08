//
//  FucusViewModel.swift
//  zhanming
//
//  Created by apple on 17/6/21.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class FucusViewModel : HomeViewModel {

}

extension FucusViewModel {
    func loadFucusData(completion : () -> ()) {
        let dataArray = SqliteTools.querySQL("SELECT * FROM t_focus;")
        
        for dict in dataArray {
            self.anchorModels.append(AnchorModel(dict: dict))
        }
        
        completion()
    }
}
