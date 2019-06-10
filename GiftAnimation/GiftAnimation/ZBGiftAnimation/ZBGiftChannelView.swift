//
//  ZBGiftChannelView.swift
//  GiftAnimation
//
//  Created by bigfish on 2019/6/6.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit
enum ZBGiftChannelState{
    case idle
    case animating
    case willEnd
    case endAnimating
}



class ZBGiftChannelView: UIView {

    @IBOutlet weak var giftBgView: UIView!
    
    @IBOutlet weak var senderIconImageView: UIImageView!
    
    @IBOutlet weak var giftImageView: UIImageView!
    
    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet weak var giftDescLabel: UILabel!
    
    @IBOutlet weak var digitLabel: ZBGiftDigitLabel!
    
    
    //当前缓存的礼物数
    fileprivate var cacheNumber : Int = 0
    //当前播放的礼物数
    fileprivate var currentNumber : Int = 0
    //礼物显示状态
    var state : ZBGiftChannelState = .idle
    //礼物加载完回调
    var complectionCallback : ((ZBGiftChannelView) ->Void)?
    
    var giftModel : ZBGiftModel?{
        didSet{
            //1 校验
            guard let gift = giftModel else {
                return
            }
            //2 设置信息
            senderIconImageView.image = UIImage(named: gift.senderIconUrl)
            senderLabel.text = gift.senderName
            giftDescLabel.text = "送出礼物：【\(gift.giftName)】"
            giftImageView.image = UIImage(named: gift.giftUrl)
            
            //3 弹出channelView
            state = .animating
            performAnimation()
        }
        
    }
    
}


// MARK: - 对外提供函数
extension ZBGiftChannelView{
    func addGiftToCache()  {
        if state == .willEnd{
            performDigitAnimation()
            // 取消接下来的动画
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
        }else{
            cacheNumber += 1
        }
        
        
    }
    
    class func  loadFromNib()->ZBGiftChannelView{
        
        return Bundle.main.loadNibNamed("ZBGiftChannelView", owner: nil, options: nil)?.first as! ZBGiftChannelView
    }
}


// MARK: - UI界面
extension ZBGiftChannelView{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        giftBgView.layer.cornerRadius = frame.height * 0.5
        senderIconImageView.layer.cornerRadius = frame.height * 0.5
        giftBgView.layer.masksToBounds = true
        senderIconImageView.layer.masksToBounds = true
        senderIconImageView.layer.borderWidth = 1
        senderIconImageView.layer.borderColor = UIColor.yellow.cgColor
    }
}


// MARK: - 动画
extension ZBGiftChannelView{
    
    /// 弹出动画
    fileprivate func performAnimation(){
        digitLabel.alpha = 1.0
        digitLabel.text = " X1 "
        UIView.animate(withDuration: 0.25, animations: {
            
            self.alpha = 1.0
            self.frame.origin.x = 0
            
        }) { isFinished in
            
            self.performDigitAnimation()
        }
        
        
    }
    
    
    /// 显示礼物动画
    fileprivate func performDigitAnimation(){
        
        currentNumber += 1
        digitLabel.text = " X\(currentNumber) "
        digitLabel.showDigit {
            //礼物动画完成后判断缓存中还有没有礼物要显示
            if self.cacheNumber > 0{
                self.cacheNumber -= 1
                self.performDigitAnimation()
            }else{
                self.state = .willEnd
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
            }
            
        }
        
    }
    
    
    /// 消失动画 释放channelView
    @objc fileprivate func performEndAnimation(){
        state = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
            
        }) { isFinished in
            self.currentNumber = 0
            self.cacheNumber = 0
            self.giftModel = nil
            self.frame.origin.x =  -self.frame.width
            self.state = .idle
            self.digitLabel.alpha = 0.0
            
            if let complectionCallback = self.complectionCallback {
                complectionCallback(self)
            }
            
        }
        
    }
    
    
    
    
}
