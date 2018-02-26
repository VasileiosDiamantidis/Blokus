//
//  tetrisPieceView.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 11/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit

class tetrisPieceView {
    
    var sizeWidth:CGFloat!
    var sizeHeight:CGFloat!
    
    var piecesHorizontal:Int!
    var piecesVertical:Int!
    
    var centerPiece:tetrisSquare!
    
    var viewContainer:UIView = UIView()
    
    init(view:UIView,piecesPerSide:Int,width:CGFloat,height:CGFloat){
        self.viewContainer = view
        self.piecesHorizontal = piecesPerSide
        self.piecesVertical = piecesPerSide
        self.sizeWidth = width
        print("Size Width: \(self.sizeWidth)")
        self.sizeHeight = height
        //self.viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: sizeWidth, height: sizeHeight))
        self.viewContainer.backgroundColor = UIColor.green
        centerPiece = tetrisSquare(pieceSize: (sizeHeight / CGFloat(self.piecesHorizontal)), passedCenter: self.viewContainer.center)
        
    }
    
    
    
    
    
    
    
    
    
    
}
