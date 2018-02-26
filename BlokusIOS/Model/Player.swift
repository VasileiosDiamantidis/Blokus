//
//  Player.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 13/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit
class Player{
    
    var name:String!
    var score:Int!
    var color:UIColor!
    var PeerID:String!
    var position:Int!
    var colorName:String!
    
    
    init(name:String,color:UIColor,PeerID:String,Position: Int){
        self.name = name
        self.color = color
        self.score = 0
        self.PeerID = PeerID
        self.position = Position
    }
    
    
    init(name:String,color:UIColor,PeerID:String){
        self.name = name
        self.color = color
        self.score = 0
        self.PeerID = PeerID
    }
    
    init(name:String,Position: Int, PeerID:String){
        self.name = name
        self.position = Position
        self.score = 0
        self.PeerID = PeerID
    }
    
    init(name:String, score:Int, color: UIColor){
        self.name = name
        self.score = score
        self.color = color
    }
    
    
    func setColorBYGR(){
        if(self.colorName == nil){
            switch self.position {
            case 0:
                self.color = UIColor.blue
                self.colorName = "Blue"
                return
            case 1:
                self.color = UIColor.yellow
                self.colorName = "Yellow"
                return
            case 2:
                self.color = UIColor.green
                self.colorName = "Green"
                return
            case 3:
                self.color = UIColor.red
                self.colorName = "Red"
                return
            default:
                print("Default ")
            }
        }else{
            self.color = colorPalete.getColorFromString(color: self.colorName)
        }
    }
    
    func comparePoints(opponent: Player) -> Bool{
        if(self.score > opponent.score){
            return true
        }else{
            return false
        }
    }
}
