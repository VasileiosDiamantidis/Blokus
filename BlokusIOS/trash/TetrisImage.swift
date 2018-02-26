//
//  TetrisImage.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 08/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit

class TetrisImage{
    
    var Image:UIImageView!
    var ImageWrong:UIImageView!
    var ImageCorrect:UIImageView!
    
    
    var centerPosition:CGPoint!
    var previousPosition:CGPoint!
    
    var squaresOrizontal:Int!
    var squaresVertical:Int!
    
    var pointsCover:[Int:Int]!
    
    var rotationStatus:Int = 0
    
    init(){}
    
}
