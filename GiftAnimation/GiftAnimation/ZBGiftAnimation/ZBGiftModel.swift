//
//  ZBGiftModel.swift
//  GiftAnimation
//
//  Created by bigfish on 2019/6/6.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ZBGiftModel: NSObject {
    
    /// 送礼物的人
    var senderName    : String = ""
    
    /// 头像
    var senderIconUrl : String = ""
    
    /// 礼物名称
    var giftName      : String = ""
    
    /// 礼物URL
    var giftUrl       : String = ""
    
    
    /// 构造函数
    ///
    /// - Parameters:
    ///   - senderName: 送礼物的人
    ///   - senderIconUrl: 头像
    ///   - giftName: 礼物名称
    ///   - giftUrl: 礼物URL
    init(senderName : String,senderIconUrl : String,giftName : String,giftUrl : String) {
        self.senderName = senderName
        self.senderIconUrl = senderIconUrl
        self.giftName = giftName
        self.giftUrl = giftUrl
    }
    
    /// 重写isEqual方法 用于判断是不是同一个人送的同一个礼物
    ///
    /// - Parameter object: 礼物对象
    /// - Returns: 是否同一个人送的同一个礼物
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? ZBGiftModel else {
            return false
        }
        
        guard obj.giftName  == giftName && obj.senderName == senderName else {
            return false
        }
        
        return true
    }
    
}
