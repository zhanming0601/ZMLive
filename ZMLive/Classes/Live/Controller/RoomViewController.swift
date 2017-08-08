//
//  LiveViewController.swift
//  zhanming
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit
import IJKMediaFramework

private let kMoreInfoViewH : CGFloat = 90
private let kGiftListViewH : CGFloat = 320
private let kSocialShareViewH : CGFloat = 250
private let kChatToolsViewH : CGFloat = 44
private let kChatContentViewH : CGFloat = 160

class RoomViewController: UIViewController {
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    // MARK: 懒加载属性
    fileprivate lazy var moreInfoView : MoreInfoView = MoreInfoView.loadMoreInfoView()
    fileprivate lazy var giftListView : GiftListView = GiftListView.loadGiftListView()
    fileprivate lazy var socialShareView : SocialShareView = SocialShareView.loadSocialShareView()
    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadChatToolsView()
    fileprivate lazy var chatContentView : ChatContentView = ChatContentView.loadChatContentView()
    
    fileprivate lazy var socket : HYSocket = HYSocket(ip: "127.0.0.1", port: 7000)
    fileprivate lazy var giftContainerView : HYGiftContainerView = HYGiftContainerView(frame: CGRect(x: 0, y: 100, width: 250, height: 100))
    
    fileprivate lazy var roomVM : RoomViewModel = RoomViewModel()
    
    
    fileprivate var player : IJKFFMoviePlayerController?
    
    // MARK: 对外提供控件属性
    var anchor : AnchorModel?
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        connectChatServer()
        loadRoomInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 设置内容
        setupAnchorInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        player?.shutdown()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
        view.addSubview(giftContainerView)
        
        setupInfo()
    }
    
    func setupInfo() {
        bgImageView.setImage(anchor?.pic74)
        iconImageView.setImage(anchor?.pic51)
        nickNameLabel.text = anchor?.name
        roomNumLabel.text = "\(anchor?.roomid ?? 0)"
        onlineLabel.text = "\(anchor?.focus ?? 0)"
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        chatContentView.frame = CGRect(x: 0, y: kScreenH - kChatContentViewH - kChatToolsViewH, width: kScreenW, height: kChatContentViewH)
        view.addSubview(chatContentView)
        
        moreInfoView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kMoreInfoViewH)
        view.addSubview(moreInfoView)
        
        giftListView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kGiftListViewH)
        view.addSubview(giftListView)
        giftListView.delegate = self
        
        socialShareView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kSocialShareViewH)
        view.addSubview(socialShareView)
        
        chatToolsView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kChatToolsViewH)
        view.addSubview(chatToolsView)
        chatToolsView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.25, animations: {
            self.moreInfoView.frame.origin.y = kScreenH
            self.giftListView.frame.origin.y = kScreenH
            self.socialShareView.frame.origin.y = kScreenH
            self.chatToolsView.frame.origin.y = kScreenH
        })
    }
}


// MARK:- 加载房间信息
extension RoomViewController {
    fileprivate func loadRoomInfo() {
        if let roomid = anchor?.roomid, let uid = anchor?.uid {
            print(roomid, uid)
            roomVM.loadLiveURL(roomid, uid, { 
                self.setupDisplayView()
            })
        }
    }
    
    fileprivate func setupDisplayView() {
        // 0.关闭log
        IJKFFMoviePlayerController.setLogReport(false)
        
        // 1.初始化播放器
        let url = URL(string: roomVM.liveURL)
        player = IJKFFMoviePlayerController(contentURL: url, with: nil)
        
        // 2.设置播放器View的位置和尺寸
        if anchor?.push == 1 {
            let screenW = UIScreen.main.bounds.width
            player?.view.frame = CGRect(x: 0, y: 150, width: screenW, height: screenW * 3 / 4)
        } else {
            player?.view.frame = view.bounds
        }
        
        // 3.将view添加到控制器的view中
        bgImageView.insertSubview(player!.view, at: 1)
        
        // 4.准备播放
        DispatchQueue.global().async {
            self.player?.prepareToPlay()
            self.player?.play()
        }
    }

}

// MARK:- 设置内容
extension RoomViewController {
    fileprivate func setupAnchorInfo() {
        bgImageView.setImage(anchor?.pic74)
        nickNameLabel.text = anchor?.name
        roomNumLabel.text = "房间号：\(anchor!.roomid)"
        iconImageView.setImage(anchor?.pic51)
        onlineLabel.text = "\(anchor!.focus)"
    }
}


// MARK:- 事件监听函数
extension RoomViewController {
    @IBAction func closeBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func focusBtnClick(btn : UIButton) {
        // 1.改变按钮的状态
        btn.isSelected = !btn.isSelected
        
        // 2.改变数据库的内容
        if btn.isSelected { // 已经关注
            anchor?.inserIntoDB()
        } else { // 取消关注
            anchor?.deleteFromDB()
        }
    }
}

// MARK:- 聊天服务器
extension RoomViewController : HYSocketDelegate {
    fileprivate func connectChatServer() {
        guard socket.connectToServer(5) else {
            print("连接服务器失败")
            return
        }
        
        socket.sendJoinRoom("why\(arc4random_uniform(10))")
        socket.delgate = self
    }
    
    func socket(socket: HYSocket, joinRoom username: String) {
        chatContentView.setNewMsg(AttributedStrGenerator.generateEnterRoom(username))
    }
    
    func socket(socket: HYSocket, leaveRoom username: String) {
        print("离开房间")
    }
    
    func socket(socket: HYSocket, username: String, content: String) {
        let chatMsgAttrStr = AttributedStrGenerator.generateContent(username, content, UIFont.systemFont(ofSize: 15))
        chatContentView.setNewMsg(chatMsgAttrStr)
    }
    
    func socket(socket: HYSocket, usename: String, giftName: String, giftURL: String) {
        let giftMsgAttrStr = AttributedStrGenerator.generateGift(usename, giftName, giftURL)
        chatContentView.setNewMsg(giftMsgAttrStr)
        
        let gift1 = HYGiftModel(senderName: usename, senderURL: "icon1", giftName: giftName, giftURL: giftURL)
        giftContainerView.insertGiftModel(gift1)
    }
}


// MARK:- 顶部菜单的点击
extension RoomViewController {
    @IBAction func starItemClick(starItem : UIButton) {
        starItem.isSelected = !starItem.isSelected
        starItem.isSelected ? AnimManager.shareInstance.addGranuleAnim(view: view) : AnimManager.shareInstance.removeGranuleAnim()
    }
    
    @IBAction func moreItemClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.moreInfoView.frame.origin.y = kScreenH - kMoreInfoViewH
        })
    }
    
    @IBAction func giftItemClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.giftListView.frame.origin.y = kScreenH - kGiftListViewH
        })
    }
    
    @IBAction func shareItemClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.socialShareView.frame.origin.y = kScreenH - kSocialShareViewH
        })
        
        self.socialShareView.showShareView()
    }
    
    @IBAction func chatItemClick() {
        chatToolsView.inputTextField.becomeFirstResponder()
    }
    
    
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewH
        
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.chatToolsView.frame.origin.y = inputViewY
            self.chatContentView.frame.origin.y = inputViewY - kChatContentViewH
        })
    }
}


extension RoomViewController : ChatToolsViewDelegate {
    func chatToolsView(toolView: ChatToolsView, message: String) {
        socket.sendChatMsg(message)
    }
}

extension RoomViewController : GiftListViewDelegate {
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftModel.subject, giftModel.img2)
    }
}
