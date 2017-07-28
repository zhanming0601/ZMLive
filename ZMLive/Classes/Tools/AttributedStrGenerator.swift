//
//  AttributedStrGenerator.swift
//  zhanming
//
//  Created by apple on 17/6/15.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit
import Kingfisher

class AttributedStrGenerator {
    
}

extension AttributedStrGenerator {
    class func generateEnterRoom(_ username : String) -> NSAttributedString {
        let chatMessage = username + " 进入房间"
        let chatMsgStr = NSMutableAttributedString(string: chatMessage)
        let range = NSRange(location: 0, length: username.characters.count)
        chatMsgStr.setAttributes([NSForegroundColorAttributeName : UIColor.orange], range: range)
        
        return chatMsgStr
    }
    
    class func generateContent(_ username : String, _ content : String, _ font : UIFont) -> NSAttributedString {
        // 1.将用户的信息生成
        let chatMessage = username + " : " + content
        
        // 2.生成字符串
        let chatMsgAttrStr = NSMutableAttributedString(string: chatMessage)
        let userRange = NSRange(location: 0, length: username.characters.count)
        chatMsgAttrStr.setAttributes([NSForegroundColorAttributeName : UIColor.orange], range: userRange)
        
        // 3.匹配字符串中的表情
        // 3.1.创建匹配规则
        let pattern = "\\[.*?\\]"
        
        // 3.2.创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return chatMsgAttrStr
        }
        
        // 3.3.匹配结果
        let resultArray = regex.matches(in: chatMessage, options: [], range: NSRange(location: userRange.length, length: chatMessage.characters.count - userRange.length))
        
        // 3.4.根据结果进行替换
        for i in (0..<resultArray.count).reversed() {
            let result = resultArray[i]
            
            let imageName = (chatMessage as NSString).substring(with: result.range)
            guard let image = UIImage(named: imageName) else {
                continue
            }
            
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let imageAttrStr = NSAttributedString(attachment: attachment)
            
            chatMsgAttrStr.replaceCharacters(in: result.range, with: imageAttrStr)
        }
        
        return chatMsgAttrStr
    }
    
    class func generateGift(_ username : String, _ giftName : String, _ giftURL : String) -> NSAttributedString {
        // 1.生成整个字符串
        let giftMessage = username + " 送 " + giftName + " "
        
        // 2.改变字符串的属性
        let giftChatAttrStr = NSMutableAttributedString(string: giftMessage)
        
        // 3.改变名称的颜色
        let userRange = NSRange(location: 0, length: username.characters.count)
        giftChatAttrStr.setAttributes([NSForegroundColorAttributeName : UIColor.orange], range: userRange)
        
        // 4.改变礼物名称的颜色
        let giftRange = (giftMessage as NSString).range(of: giftName)
        giftChatAttrStr.setAttributes([NSForegroundColorAttributeName : UIColor(r: 102, g: 255, b: 255)], range: giftRange)
        
        // 5.礼物的图片
        guard let giftImage = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: giftURL) else {
            return giftChatAttrStr
        }
        
        // 6.根据图片创建字符串
        let attachment = NSTextAttachment()
        attachment.image = giftImage
        let font = UIFont.systemFont(ofSize: 15.0)
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let giftAttrStr = NSAttributedString(attachment: attachment)
        
        giftChatAttrStr.append(giftAttrStr)
        
        return giftChatAttrStr
    }
}
