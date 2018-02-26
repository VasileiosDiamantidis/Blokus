//
//  results.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 29/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit

class results: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var winner: [UILabel]!
    @IBOutlet var second: [UILabel]!
    @IBOutlet var third: [UILabel]!
    @IBOutlet var fourth: [UILabel]!
    
    var gVC:gameAdaptiveViewController!
    
    
    @IBAction func LobbyBtnPressed(_ sender: Any) {
        self.goToLoby()
        
    }
    
    
    func goToLoby(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "HomeNavController")
        self.gVC.present(controller, animated: true, completion: nil)
    }
}
