//
//  ChatContentView.swift
//  zhanming
//
//  Created by apple on 17/6/15.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

private let kChatCellID = "kChatCellID"

class ChatContentView: UIView {
    
    fileprivate var contents : [NSAttributedString] = [NSAttributedString]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: kChatCellID)
    }
}


extension ChatContentView {
    class func loadChatContentView() -> ChatContentView {
        return Bundle.main.loadNibNamed("ChatContentView", owner: nil, options: nil)?.first as! ChatContentView
    }
    
    func setNewMsg(_ msgAttrStr : NSAttributedString) {
        contents.append(msgAttrStr)
        tableView.reloadData()
        let indexPath = IndexPath(row: contents.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension ChatContentView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatCellID, for: indexPath) as! ChatViewCell
        
        cell.contentLabel.attributedText = contents[indexPath.row]
        
        return cell
    }
}
