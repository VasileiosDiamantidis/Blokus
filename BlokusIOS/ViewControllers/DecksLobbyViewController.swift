//
//  DecksLobbyViewController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 27/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit

class DecksLobbyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myDecks:[Deck] = []
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myTopLabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.updateLabels()
        return self.myDecks.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DecksCollectionViewCell", for: indexPath) as! DecksCollectionViewCell
        
        cell.lblName.text = self.myDecks[indexPath.row].name
        cell.lblSquares.text = String(self.myDecks[indexPath.row].numberOfSquares)
        cell.lblPices.text = String(self.myDecks[indexPath.row].numberOfPieces)
        //cell.lblName.text = self.myDecks[indexPath.row].name
        cell.lblDate.text = self.myDecks[indexPath.row].date
        cell.myCollectionView = self.myCollectionView
        cell.myIndexPath = indexPath
        cell.decksLobbyViewController = self
        cell.addRandomImages()
        cell.deckData = self.myDecks[indexPath.row]
        var SelectedDect:Deck!
        if let deckToReturn = NSKeyedUnarchiver.unarchiveObject(withFile: Deck.ArchiveURLSelectedDeck.path) as? Deck{
            SelectedDect = deckToReturn
            if((self.myDecks[indexPath.row].name == SelectedDect.name) && (SelectedDect.numberOfSquares == self.myDecks[indexPath.row].numberOfSquares) && (SelectedDect.numberOfPieces == self.myDecks[indexPath.row].numberOfPieces)){
                cell.lblName.backgroundColor = UIColor.yellow
            }
        }
        
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.myCollectionView = CGSize(width: self.myCollectionView.frame.height / 3 * 2, height: self.myCollectionView.frame.height / 3 * 2)
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.getStoredDecks()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.myCollectionView.frame.height / 3 * 2, height: self.myCollectionView.frame.height / 3 * 2)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (self.myCollectionView.frame.height / 3 * 2) / 15
    }
        
        
    

    override func viewDidAppear(_ animated: Bool) {
        self.myCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStoredDecks(){
        if let decksToReturn = NSKeyedUnarchiver.unarchiveObject(withFile: Deck.ArchiveURL.path) as? [Deck]{
            self.myDecks = decksToReturn
        }
        
    }
    
    func updateLabels(){
        myTopLabel.text = "number of Decks = \(myDecks.count)"
    }
    
    func setSelectedDeck(myIndexPath: IndexPath){
        var sellectedCell:DecksCollectionViewCell = myCollectionView.cellForItem(at: myIndexPath) as! DecksCollectionViewCell
        for cell in myCollectionView.visibleCells{
            var decksCell:DecksCollectionViewCell = cell as! DecksCollectionViewCell
            if(decksCell == sellectedCell){
                decksCell.lblName.backgroundColor = UIColor.yellow
            }else{
                decksCell.lblName.backgroundColor = UIColor.flatSand()
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
