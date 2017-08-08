//
//  FucusViewController.swift
//  zhanming
//
//  Created by apple on 17/6/21.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kFucusCellID = "kFucusCellID"

class FucusViewController: UITableViewController {
    
    fileprivate lazy var focusVM : FucusViewModel = FucusViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadFucusData()
    }

}


extension FucusViewController {
    fileprivate func setupUI() {
        title = "我的关注"
        navigationController?.navigationBar.tintColor = UIColor.white
        tableView.register(UINib(nibName: "FocusViewCell", bundle: nil), forCellReuseIdentifier: kFucusCellID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func loadFucusData() {
        focusVM.loadFucusData {
            self.tableView.reloadData()
        }
    }
}


// MARK:- 数据源&代理方法
extension FucusViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusVM.anchorModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kFucusCellID, for: indexPath) as! FocusViewCell
        
        cell.anchorModel = focusVM.anchorModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        roomVc.anchor = focusVM.anchorModels[indexPath.row]
        navigationController?.pushViewController(roomVc, animated: true)
    }
}
