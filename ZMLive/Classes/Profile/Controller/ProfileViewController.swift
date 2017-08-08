//
//  ProfileViewController.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class ProfileViewController: BaseProfileViewController {
    
    fileprivate lazy var headerView : ProfileHeaderView = ProfileHeaderView.loadProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension ProfileViewController {
    override func setupUI() {
        super.setupUI()
        
        automaticallyAdjustsScrollViewInsets = false
        
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 200)
        tableView.tableHeaderView = headerView
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 60))
        footerView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.tableFooterView = footerView
    }
    
    override func setupData() {
        // 1.第一组数据
        let section0Model = SettingsSectionModel()
        section0Model.sectionHeaderHeight = 5
        
        let section0Item = SettingsItemModel(icon: "mine_follow", content: "我的关注")
        section0Model.itemArray.append(section0Item)
        let section1Item = SettingsItemModel(icon: "mine_money", content: "我的帆币")
        section0Model.itemArray.append(section1Item)
        let section2Item = SettingsItemModel(icon: "mine_fanbao", content: "我的帆宝")
        section0Model.itemArray.append(section2Item)
        let section3Item = SettingsItemModel(icon: "mine_bag", content: "我的背包")
        section3Item.accessoryType = .arrowHint
        section3Item.hintText = "查看礼物"
        section0Model.itemArray.append(section3Item)
        let section4Item = SettingsItemModel(icon: "mine_money", content: "现金红包")
        section0Model.itemArray.append(section4Item)
        
        sections.append(section0Model)
        
        // 2.第二组数据
        let section1Model = SettingsSectionModel()
        section1Model.sectionHeaderHeight = 5
        
        let section1Item0 = SettingsItemModel(icon: "mine_edit", content: "编辑资料")
        section1Model.itemArray.append(section1Item0)
        let section1Item1 = SettingsItemModel(icon: "mine_set", content: "设置")
        section1Model.itemArray.append(section1Item1)
        
        sections.append(section1Model)
        
        // 3.刷新表格
        tableView.reloadData()
    }
}


extension ProfileViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        if indexPath.section == 1 && indexPath.item == 1 {
            let settingsVc = SettingsViewController()
            navigationController?.pushViewController(settingsVc, animated: true)
        }
    }
}
