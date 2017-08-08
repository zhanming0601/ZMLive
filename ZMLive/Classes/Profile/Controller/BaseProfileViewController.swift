//
//  BaseProfileViewController.swift
//  zhanming
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kProfileCellID = "kProfileCellID"

class BaseProfileViewController: UIViewController {
    
    lazy var tableView : UITableView = UITableView()
    lazy var sections : [SettingsSectionModel] = [SettingsSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
}

extension BaseProfileViewController {
    func setupUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: kProfileCellID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
    }
}

extension BaseProfileViewController {
    func setupData() {
        
    }
}



extension BaseProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileCellID, for: indexPath) as! ProfileViewCell
        
        let section = sections[indexPath.section]
        cell.itemModel = section.itemArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].sectionHeaderHeight
    }
}
