//
//  ChatToolsView.swift
//  zhanming
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 coderzm. All rights reserved.
//

import UIKit

protocol ChatToolsViewDelegate : class {
    func chatToolsView(toolView : ChatToolsView, message : String)
}

class ChatToolsView: UIView {
    
    weak var delegate : ChatToolsViewDelegate?
    
    fileprivate lazy var emoticonBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    fileprivate lazy var emotionView : EmoticonView = EmoticonView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 206), emoticonClickCallback : {[weak self] (emoticon : Emoticon) in
        self?.insertEmotion(emoticon)
    })
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        sendMsgBtn.isEnabled = sender.text!.characters.count != 0
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        // 1.获取内容
        let message = inputTextField.text!
        
        // 2.清空内容
        inputTextField.text = ""
        sender.isEnabled = false
        
        // 3.将内容回调出去
        delegate?.chatToolsView(toolView: self, message: message)
    }
}


extension ChatToolsView {
    fileprivate func setupUI() {
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
    }
}

extension ChatToolsView {
    class func loadChatToolsView() -> ChatToolsView {
        return Bundle.main.loadNibNamed("ChatToolsView", owner: nil, options: nil)?.first as! ChatToolsView
    }
}


extension ChatToolsView {
    @objc fileprivate func emoticonBtnClick(_ btn : UIButton) {
        btn.isSelected = !btn.isSelected
        
        let textRange = inputTextField.selectedTextRange
        
        inputTextField.resignFirstResponder()
        inputTextField.inputView = inputTextField.inputView == nil ? emotionView : nil
        inputTextField.becomeFirstResponder()
        
        inputTextField.selectedTextRange = textRange
    }
    
    fileprivate func insertEmotion(_ emoticon : Emoticon) {
        // 1.点击了删除按钮
        if emoticon.emoticonName == "delete-n" {
            inputTextField.deleteBackward()
            return
        }
        
        // 2.插入文字
        inputTextField.replace(inputTextField.selectedTextRange!, withText: emoticon.emoticonName)
    }
}
