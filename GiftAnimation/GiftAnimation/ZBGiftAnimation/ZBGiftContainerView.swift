//
//  ZBGiftContainerView.swift
//  GiftAnimation
//
//  Created by bigfish on 2019/6/10.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

private let kChannelCount = 2 // 只同时显示2个礼物
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10


class ZBGiftContainerView: UIView {
    fileprivate lazy var channelViews : [ZBGiftChannelView] = [ZBGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [ZBGiftModel]  = [ZBGiftModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZBGiftContainerView {
    fileprivate func setupUI() {
        // 1.根据当前的渠道数，创建HYGiftChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
            let channelView = ZBGiftChannelView.loadFromNib()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.complectionCallback = { channelView in
                // 1 取出缓存模型
                guard self.cacheGiftModels.count != 0 else{
                    return
                }
                // 2 取出第一个
                let firstModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
                
                // 3 让闲置的View 显示动画
                channelView.giftModel = firstModel
                
                // 4 将缓存中与giftModel 相同的模型放入channelView缓存
                
                for i in (0..<self.cacheGiftModels.count).reversed(){
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstModel){
                        channelView.addGiftToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
            
            
        }
    }
}

extension ZBGiftContainerView{
    func showGiftModel(_ giftModel : ZBGiftModel)  {
        // 1 判断正在使用的channelView和赠送的礼物关系
        if let channelView = checkUsingChannelView(giftModel){
            channelView.addGiftToCache()
            return
        }
        // 2 判断有没有闲置的channelView
        if let channelView = checkIdleChannelView(){
            channelView.giftModel = giftModel
            return
        }
        // 3 数据放入缓存
        cacheGiftModels.append(giftModel)
        
    }
    
    
    /// 判断正在显示的礼物是不是和现在添加的礼物是不是同一个
    ///
    /// - Parameter giftModel: <#giftModel description#>
    /// - Returns: <#return value description#>
    private func checkUsingChannelView(_ giftModel : ZBGiftModel) -> ZBGiftChannelView?{
        for channelView in channelViews{
            if giftModel.isEqual(channelView.giftModel) && channelView.state != .endAnimating{
                return channelView
            }
        }
        return nil
    }
    
    
    /// 获取闲置的channelView
    ///
    /// - Returns: <#return value description#>
    private func checkIdleChannelView()->ZBGiftChannelView?{
        for channelView in channelViews {
            if channelView.state == .idle{
                return channelView
            }
        }
        
        return nil
    }
    

}
