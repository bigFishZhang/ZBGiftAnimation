//
//  ZBGiftDigitLabel.swift
//  GiftAnimation
//
//  Created by bigfish on 2019/6/6.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ZBGiftDigitLabel: UILabel {
    
    /// 重写绘制
    ///
    /// - Parameter rect: <#rect description#>
    override func drawText(in rect: CGRect) {
        // 1 获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        // 2 描边
        context?.setLineWidth(6)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.red
        super.drawText(in: rect)
        
        // 3 填充
        context?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        super.drawText(in: rect)
    }
    
    
    /// 显示数字动画 先放大 再缩小 再恢复正常大小
    ///
    /// - Parameter completion: 显示完成回调block
    func showDigit(_ completion : @escaping () ->())  {
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: [], animations: {
            // 1 放大
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 4.5, y: 4.5)
            })
            // 2 缩小
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            })
            
        }) { isFinished in
            // 3 恢复正常大小
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (isFinished) in
                completion()
            })
        }
    }

}
