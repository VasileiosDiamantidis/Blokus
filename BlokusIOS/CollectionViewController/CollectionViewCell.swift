//
//  CollectionViewCell.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 27/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var viewToPlaceImage: UIView!
    var list:[[Int]]!
    
    var myCollectionView:UICollectionView!
    var myPiecesStack:UIStackView!
    var myCreateDeckViewController:CreateDeckViewController!
    var myIndexPath:IndexPath!
    
    @IBAction func EditPiece(_ sender: UIButton) {
        edit()
        delete()
    }
    
    @IBAction func deletePiece(_ sender: UIButton) {
        self.delete()
        //self.removeFromSuperview()
    }
    
    
    
    func edit(){
                var metr = 0
                for btn in self.myCreateDeckViewController.Buttons{
                    var row = metr / 5
                    var cell = metr - (row * 5)
                    if(self.list[row][cell] == 1){
                        btn.backgroundColor = UIColor.flatBlack()
                    }else{
                       btn.backgroundColor = UIColor.flatWhite()
                    }
                    metr = metr + 1
                }
        
        
    }
    
    
    
    func delete(){
        self.myCreateDeckViewController.piecesLeft = self.myCreateDeckViewController.piecesLeft + 1
        self.myCreateDeckViewController.squaresUsed = self.myCreateDeckViewController.squaresUsed - self.getNumperofPieces()
        //self.myCollectionView.reloadItems(at: [self.myIndexPath])
        self.myCreateDeckViewController.images.remove(at: self.myIndexPath.row)
        self.myCollectionView.reloadData()
        self.myCreateDeckViewController.updateLabels()
    }
    
    func getNumperofPieces() -> Int{
        var numberOfPieces = 0
        for l in list{
            for num in l{
                if num == 1{
                    numberOfPieces = numberOfPieces + 1
                }
            }
        }
        
        
        
        return numberOfPieces
    }
}
