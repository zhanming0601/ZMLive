//
//  SettingsViewController.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class SettingsViewController: BaseProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SettingsViewController {
    override func setupData() {
        // 1.第一组数据
        let section0Model = SettingsSectionModel()
        section0Model.sectionHeaderHeight = 5
        
        let section0Item = SettingsItemModel(content: "开播提醒")
        section0Item.accessoryType = .onswitch
        section0Model.itemArray.append(section0Item)
        let section1Item = SettingsItemModel(content: "移动流量提醒")
        section1Item.accessoryType = .onswitch
        section0Model.itemArray.append(section1Item)
        let section2Item = SettingsItemModel(content: "网络环境优化")
        section2Item.accessoryType = .onswitch
        section0Model.itemArray.append(section2Item)
        
        sections.append(section0Model)
        
        // 2.第二组数据
        let section1Model = SettingsSectionModel()
        section1Model.sectionHeaderHeight = 5
        
        let section1Item0 = SettingsItemModel(content: "绑定手机", hint : "未绑定")
        section1Item0.accessoryType = .arrowHint
        section1Model.itemArray.append(section1Item0)
        let section1Item1 = SettingsItemModel(content: "意见反馈")
        section1Model.itemArray.append(section1Item1)
        let section1Item2 = SettingsItemModel(content: "直播公约")
        section1Model.itemArray.append(section1Item2)
        let section1Item3 = SettingsItemModel(content: "关于我们")
        section1Model.itemArray.append(section1Item3)
        let section1Item4 = SettingsItemModel(content: "我要好评")
        section1Model.itemArray.append(section1Item4)
        
        sections.append(section1Model)
        
        // 3.刷新表格
        tableView.reloadData()
    }
}
