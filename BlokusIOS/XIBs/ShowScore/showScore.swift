//
//  showScoreController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 28/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit

class showScore: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    //@IBOutlet weak var contentView: UIView!
    
    @IBOutlet var p1: [UILabel]!
    @IBOutlet var p2: [UILabel]!
    @IBOutlet var p3: [UILabel]!
    @IBOutlet var p4: [UILabel]!
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}


