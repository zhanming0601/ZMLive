//
//  DetailRankViewController.swift
//  zhanming
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

private let kRankCellID = "kRankCellID"


class DetailRankViewController: UIViewController {
    
    var rankType : RankType
    lazy var tableView : UITableView = UITableView()
    
    fileprivate lazy var detailRankVM : DetailRankViewModel = DetailRankViewModel()
    
    init(rankType : RankType) {
        self.rankType = rankType
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
}

extension DetailRankViewController {
    fileprivate func setupUI() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.rowHeight = 50
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DetailRankViewCell", bundle: nil), forCellReuseIdentifier: kRankCellID)
    }
}


extension DetailRankViewController {
    func loadData() {
        detailRankVM.loadDetailRankData(rankType, {
            self.tableView.reloadData()
        })
    }
}

extension DetailRankViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailRankVM.rankModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRankCellID, for: indexPath) as! DetailRankViewCell
        
        cell.rankNum = indexPath.row
        cell.rankModel = detailRankVM.rankModels[indexPath.row]
        
        return cell
    }
}


