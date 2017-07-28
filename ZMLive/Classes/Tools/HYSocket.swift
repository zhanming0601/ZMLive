//
//  HYSocket.swift
//  ChatClient
//
//  Created by apple on 17/6/15.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

protocol HYSocketDelegate : class {
    func socket(socket : HYSocket, joinRoom username : String)
    func socket(socket : HYSocket, leaveRoom username : String)
    func socket(socket : HYSocket, username : String, content : String)
    func socket(socket : HYSocket, usename : String, giftName : String, giftURL : String)
}

class HYSocket {
    
    weak var delgate : HYSocketDelegate?
    
    fileprivate var socketClient : TCPClient!
    fileprivate var isConnected : Bool = false
    
    init(ip : String, port : Int) {
        socketClient = TCPClient(addr: ip, port: port)
    }
}


// MARK:- 链接过程
extension HYSocket {
    func connectToServer(_ timeount : Int) -> Bool {
        let flag = socketClient.connect(timeout: timeount)
        if flag.0 {
            isConnected = true
            
            // 开始读取消息
            DispatchQueue.global().async {
                self.readServerMsg()
            }
        }
        return flag.0
    }
    
}


// MARK:- 读取消息过程
extension HYSocket {
    fileprivate func readServerMsg() {
        while isConnected {
            if let data = socketClient.read(4) {
                if data.count == 4 {
                    let ndata = Data(bytes: data, count: data.count)
                    var length : UInt8 = 0
                    ndata.copyBytes(to: &length, count: data.count)
                    
                    if let buff = socketClient.read(Int(length)) {
                        let msgData = Data(bytes: buff, count: buff.count)
                        let msgDict = (try? JSONSerialization.jsonObject(with: msgData, options: .mutableContainers)) as! [String : Any]
                        DispatchQueue.main.async {
                            self.handleMsg(msgDict)
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func handleMsg(_ msgDict : [String : Any]) {
        let msgType = msgDict["msgType"] as! Int
        
        let username = msgDict["nickname"] as! String
        
        switch msgType {
        case 0:
            delgate?.socket(socket: self, joinRoom: username)
        case 1:
            let content = msgDict["content"] as! String
            delgate?.socket(socket: self, username: username, content: content)
        case 2:
            let giftName = msgDict["giftname"] as! String
            let giftURL = msgDict["giftURL"] as! String
            delgate?.socket(socket: self, usename: username, giftName: giftName, giftURL: giftURL)
        case 10:
            delgate?.socket(socket: self, leaveRoom: username)
        default:
            print("其他消息")
        }
    }
}


// MARK:- 发送消息
extension HYSocket {
    func sendJoinRoom(_ nickName : String) {
        var msgDict = [String : Any]()
        msgDict["msgType"] = 0
        msgDict["nickname"] = nickName
        sendMsg(msgDict)
    }
    
    func sendLeaveRoom(_ nickName : String) {
        var msgDict = [String : Any]()
        msgDict["msgType"] = 10
        msgDict["nickname"] = nickName
        sendMsg(msgDict)
    }
    
    func sendChatMsg(_ content : String) {
        var msgDict = [String : Any]()
        msgDict["msgType"] = 1
        msgDict["content"] = content
        sendMsg(msgDict)
    }
    
    func sendGiftMsg(_ giftName : String, _ giftImgURL : String) {
        var msgDict = [String : Any]()
        msgDict["msgType"] = 2
        msgDict["giftname"] = giftName
        msgDict["giftURL"] = giftImgURL
        sendMsg(msgDict)
    }
    
    
    fileprivate func sendMsg(_ msgDict : [String : Any]) {
        let msgdata=try? JSONSerialization.data(withJSONObject: msgDict,
                                                options: .prettyPrinted)
        var len:Int32=Int32(msgdata!.count)
        let data:NSMutableData = NSMutableData(bytes: &len, length: 4)
        _ = socketClient.send(data: data as Data)
        _ = socketClient.send(data:msgdata! as Data)
    }
}
