//
//  WeeklyRankViewController.swift
//  zhanming
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

private let kWeeklyRankeCellID = "kWeeklyRankeCellID"

class WeeklyRankViewController: DetailRankViewController {
    
    fileprivate lazy var weeklyRankVM : WeeklyRankViewModel = WeeklyRankViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "WeeklyRankViewCell", bundle: nil), forCellReuseIdentifier: kWeeklyRankeCellID)
    }
    
    override init(rankType: RankType) {
        super.init(rankType: rankType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WeeklyRankViewController {
    override func loadData() {
        weeklyRankVM.loadWeeklyRankData(rankType, {
            self.tableView.reloadData()
        })
    }
}

extension WeeklyRankViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return weeklyRankVM.weeklyRanks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyRankVM.weeklyRanks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kWeeklyRankeCellID, for: indexPath) as! WeeklyRankViewCell
        
        cell.weekly = weeklyRankVM.weeklyRanks[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "主播周星榜" : "富豪周星榜"
    }
}
