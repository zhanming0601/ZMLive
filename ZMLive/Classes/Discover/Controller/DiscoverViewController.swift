//
//  DiscoverViewController.swift
//  zhanming
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var carouselView : CarouselView = CarouselView.loadCarouseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}


// MARK:- 设置UI界面
extension DiscoverViewController {
    fileprivate func setupUI() {
        setupHeaderView()
        setupFooterView()
        
        tableView.rowHeight = kScreenW * 1.4
    }
    
    private func setupHeaderView() {
        let carouseViewH = kScreenW * 0.4
        carouselView.frame = CGRect(x: 0, y: -carouseViewH, width: kScreenW, height: carouseViewH)
        tableView.tableHeaderView = carouselView
    }
    
    fileprivate func setupFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 80))
        
        let btn = UIButton(frame: CGRect.zero)
        btn.frame.size = CGSize(width: kScreenW * 0.5, height: 40)
        btn.center = CGPoint(x: kScreenW * 0.5, y: 40)
        btn.setTitle("换一换", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.borderWidth = 0.5
        btn.addTarget(self, action: #selector(switchGuessAnchor), for: .touchUpInside)
        
        footerView.addSubview(btn)
        footerView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        tableView.tableFooterView = footerView
    }
    
    fileprivate func setupSectionHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        headerLabel.textAlignment = .center
        headerLabel.text = "猜你喜欢"
        headerLabel.textColor = UIColor.orange
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    @objc private func switchGuessAnchor() {
        let cell = tableView.visibleCells.first as? DiscoverTableViewCell
        cell?.reloadData()
        let offset = CGPoint(x: 0, y: kScreenW * 0.4 - 64)
        tableView.setContentOffset(offset, animated: true)
    }
}

// MARK:- UITableView的数据源&代理
extension DiscoverViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverTableCellID", for: indexPath) as! DiscoverTableViewCell
        
        cell.cellDidSelected = { (anchor : AnchorModel) in
            let liveVc = RoomViewController()
            liveVc.anchor = anchor
            self.navigationController?.pushViewController(liveVc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
