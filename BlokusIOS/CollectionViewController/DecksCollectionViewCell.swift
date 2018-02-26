//
//  DecksCollectionViewCell.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 27/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit

class DecksCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPices: UILabel!
    @IBOutlet weak var lblSquares: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var imgPieceOutlest: UIImageView!
    @IBOutlet weak var imgSquareOutlet: UIImageView!
    
    var deckData:Deck!
    
    var myCollectionView: UICollectionView!
    var myIndexPath:IndexPath!
    var decksLobbyViewController:DecksLobbyViewController!
    
    var squareImages:[UIImage] = [#imageLiteral(resourceName: "square1"),#imageLiteral(resourceName: "square2"),#imageLiteral(resourceName: "square3")]
    var pieceImages:[UIImage] = [#imageLiteral(resourceName: "piece1"),#imageLiteral(resourceName: "piece2"),#imageLiteral(resourceName: "piece3"),#imageLiteral(resourceName: "piece4")]
    @IBAction func deleteBtnPressed(_ sender: Any) {
        
        self.deleteDeck()
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        self.editMe()
    }
    
    @IBAction func useBtnPressed(_ sender: Any) {
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(self.deckData, toFile: Deck.ArchiveURLSelectedDeck.path)
        if(isSuccesfulSave){
            print("Successfull Save")
            self.decksLobbyViewController.setSelectedDeck(myIndexPath: myIndexPath)
        }else{
            print("Unsuccessfull Save")
        }
    }
    
    func deleteDeck(){
        //self.myCollectionView.reloadItems(at: [self.myIndexPath])
        deleteMe()
    }
    
    
    func deleteMe(){
        var tmpDecks:[Deck] = []
        if let decksToReturn = NSKeyedUnarchiver.unarchiveObject(withFile: Deck.ArchiveURL.path) as? [Deck]{
            tmpDecks = decksToReturn
        }
        tmpDecks.remove(at: self.myIndexPath.row)
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(tmpDecks, toFile: Deck.ArchiveURL.path)
        if(isSuccesfulSave){
            print("Successfull Save")
        }else{
            print("Unsuccessfull Save")
        }
        self.decksLobbyViewController.myDecks.remove(at: self.myIndexPath.row)
        self.myCollectionView.reloadData()
        self.decksLobbyViewController.updateLabels()
    }
    
    
    
    
    
    
    func editMe(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        var editDeckViewController:CreateDeckViewController = storyBoard.instantiateViewController(withIdentifier: "CreateDeckViewController") as! CreateDeckViewController
        editDeckViewController.piecesLeft = (20 - Int(self.deckData.numberOfPieces))
        editDeckViewController.name = self.deckData.name
        editDeckViewController.squaresUsed = Int(self.deckData.numberOfSquares)
        editDeckViewController.images = self.deckData.myListOfData
        //editDeckViewController.updateLabels()
        //editDeckViewController.myCollectionView.reloadData()
        self.deleteMe()
        self.decksLobbyViewController.present(editDeckViewController, animated:true, completion:nil)
        
    }
    
    
    func addRandomImages(){
        var SquaresRanInt:Int = Int(arc4random_uniform(UInt32(squareImages.count - 1)))
        self.imgSquareOutlet.image = squareImages[SquaresRanInt]
        var PieceRanInt:Int = Int(arc4random_uniform(UInt32(pieceImages.count - 1)))
        self.imgPieceOutlest.image = pieceImages[PieceRanInt]
    }
}
