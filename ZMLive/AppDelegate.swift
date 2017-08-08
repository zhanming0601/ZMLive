//
//  AppDelegate.swift
//  zhanming
//
//  Created by apple on 17/6/8.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 创建数据库对象
        setupFocusDB()
        
        // 设置导航栏颜色
        setupNavigationBar()
        
        return true
    }
}


extension AppDelegate {
    fileprivate func setupFocusDB() {
        SqliteTools.openDB(String.documentPath + "/focus.sqlite")
        let createFocusTable = "CREATE TABLE IF NOT EXISTS t_focus ( " +
                                    "roomid INTEGER PRIMARY KEY, " +
                                    "name TEXT, " +
                                    "pic51 TEXT, " +
                                    "pic74 TEXT, " +
                                    "live INTEGER " +
                                ");"
        SqliteTools.execSQL(createFocusTable)
    }
    
    fileprivate func setupNavigationBar() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = .black
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let tabbar = UITabBar.appearance()
        tabbar.isTranslucent = false
        
        let headerLabel = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
        headerLabel.textColor = UIColor.orange
        headerLabel.font = UIFont.systemFont(ofSize: 14.0)
    }
}

