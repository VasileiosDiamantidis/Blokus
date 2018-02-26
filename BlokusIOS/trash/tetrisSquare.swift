//
//  tetrisSquare.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 11/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit

class tetrisSquare{
    
    var viewSquare:UIView=UIView()
    var parentView:UIView!
    
    var pieceSize:CGFloat!
    
    var rightPiece:tetrisSquare!
    var leftPiece:tetrisSquare!
    var topPiece:tetrisSquare!
    var bottomPiece:tetrisSquare!
    var myX:CGFloat!
    var myY:CGFloat!
    
    var square:CGRect!
    var center:CGPoint!
    
    
    var pieces:[tetrisSquare]=[]
    
    init(pieceSize:CGFloat,passedCenter:CGPoint){
        self.pieceSize = pieceSize
        self.center = passedCenter
        //pieces = [rightPiece!,leftPiece!,topPiece!,bottomPiece!]
        
        
    }
    
    
    func includeMySquare(toAView: UIView){
        myX = (toAView.frame.width / 2) - (pieceSize / 2)
        myY = (toAView.frame.height / 2) - (pieceSize / 2)
        viewSquare = UIView(frame: CGRect(x: myX, y: myY, width: pieceSize, height: pieceSize))
        viewSquare.backgroundColor = UIColor.blue
        viewSquare.layer.borderColor = UIColor.black.cgColor
        viewSquare.layer.borderWidth = 2
        toAView.addSubview(viewSquare)
        self.parentView = toAView
    }
    
    func addRightSquare(toAview:UIView){
        var newX = self.myX - self.pieceSize
        var newY = self.myY
        self.rightPiece = createSquare(passedCenter:CGPoint(x:newX,y:newY!), toAView: toAview)
        self.rightPiece.leftPiece = self
        self.pieces.append(rightPiece)
        self.rightPiece.leftPiece.pieces.append(self)//auto mporei na kanei infinite loops!!!!
    }
    
    func addLeftSquare(toAview:UIView){
        var newX = self.myX + self.pieceSize
        var newY = self.myY
        self.leftPiece = createSquare(passedCenter:CGPoint(x:newX,y:newY!), toAView: toAview)
        self.leftPiece.rightPiece = self
        self.pieces.append(leftPiece)
        self.leftPiece.rightPiece.pieces.append(self)//auto mporei na kanei infinite loops!!!!
    }
    
    
    func addTopSquare(toAview:UIView){
        var newX = self.myX
        var newY = self.myX + self.pieceSize
        self.topPiece = createSquare(passedCenter:CGPoint(x:newX!,y:newY), toAView: toAview)
        self.topPiece.bottomPiece = self
        self.pieces.append(topPiece)
        self.topPiece.bottomPiece.pieces.append(self)//auto mporei na kanei infinite loops!!!!
    }
    
    func addBotSquare(toAview:UIView){
        var newX = 0
        var newY = 0
        self.bottomPiece = createSquare(passedCenter:CGPoint(x:newX,y:newY), toAView: toAview)
        self.bottomPiece.topPiece = self
        self.pieces.append(bottomPiece)
        self.bottomPiece.topPiece.pieces.append(self)//auto mporei na kanei infinite loops!!!!
    }
    
    
    
    func createSquare(passedCenter:CGPoint,toAView:UIView)-> tetrisSquare{
        var tetrisNew = tetrisSquare(pieceSize: self.pieceSize, passedCenter: passedCenter)
        tetrisNew.includeMySquare(toAView: toAView)
        return tetrisNew
    }
    
    
    
    
    
    
}
