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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.showDigit {
            
        }
        // Do any additional setup after loading the view.
    }


}

