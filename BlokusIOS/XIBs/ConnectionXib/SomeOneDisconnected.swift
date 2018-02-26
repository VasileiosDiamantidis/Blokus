//
//  SomeOneDisconnected.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 09/01/2018.
//  Copyright © 2018 vdiamant. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class SomeOneDisconnected: UIView {

    
    
    @IBOutlet weak var waitingImg: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func RemoveMe(){
        self.removeFromSuperview()
    }
    
    func InitializeMyImage(){
//        guard let WaitingGif:UIImage = UIImage.gif(name: "waiting") as! UIImage else {
//             
//            return
//        }
//        self.waitingImg.image = WaitingGif
    }
    
}
