//
//  ViewController.swift
//  GiftAnimation
//
//  Created by bigfish on 2019/6/6.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: ZBGiftDigitLabel!
    fileprivate lazy var giftContainerView : ZBGiftContainerView = ZBGiftContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftContainerView.frame = CGRect(x: 0, y: 300, width: 350, height: 100)
        giftContainerView.backgroundColor = UIColor.lightGray
        view.addSubview(giftContainerView)
        // Do any additional setup after loading the view.
    }

    @IBAction func showTextAnimation(_ sender: Any) {
        testLabel.showDigit {
            
        }
    }
    
    @IBAction func gift1(_ sender: Any) {
        let gift1 = ZBGiftModel(senderName: "zzb", senderIconUrl: "icon1", giftName: "火箭", giftUrl: "gift1")
        giftContainerView.showGiftModel(gift1)
    }
    @IBAction func gift2(_ sender: Any) {
        let gift2 = ZBGiftModel(senderName: "zyx", senderIconUrl: "icon2", giftName: "鲜花", giftUrl: "gift2")
        giftContainerView.showGiftModel(gift2)
    }
    
    @IBAction func gift3(_ sender: Any) {
        let gift2 = ZBGiftModel(senderName: "zdy", senderIconUrl: "icon3", giftName: "金牌讲师", giftUrl: "gift3")
        giftContainerView.showGiftModel(gift2)
    }
}

