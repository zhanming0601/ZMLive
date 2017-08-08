//
//  AnchorModel.swift
//  zhanming
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class AnchorModel: BaseModel {
    var uid : String = ""
    var roomid : Int = 0
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0 // 是否在直播
    var push : Int = 0 // 直播显示方式
    var focus : Int = 0 // 关注数
    
    var isEvenIndex : Bool = false
}


extension AnchorModel {
    func inserIntoDB() {
        // 1.拼接插入语句
        let insertSQL = "INSERT INTO t_focus (roomid, name, pic51, pic74, live) VALUES (\(roomid), '\(name)', '\(pic51)', '\(pic74)', \(live));"
        
        // 2.执行语句
        if SqliteTools.execSQL(insertSQL) {
            print("插入成功")
        } else {
            print("插入失败")
        }
    }
    
    func deleteFromDB() {
        // 1.拼接删除语句
        let deleteSQL = "DELETE FROM t_focus WHERE roomid = \(roomid);"
        
        // 2.执行语句
        if SqliteTools.execSQL(deleteSQL) {
            print("删除成功")
        } else {
            print("删除失败")
        }
    }
}
