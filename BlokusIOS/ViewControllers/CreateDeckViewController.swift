//
//  CreateDeckViewController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 27/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit
import ChameleonFramework
class CreateDeckViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    
    var primeColor:UIColor!
    var compositeColor:UIColor!
    var piecesLeft:Int = 20
    var squaresUsed:Int = 0
    var name:String = "myDeck"
    @IBOutlet weak var nameTxtBox: UITextField!
    
    
    @IBOutlet weak var lblPiecesLeft: UILabel!
    @IBOutlet weak var lblSquaresUsed: UILabel!
    @IBOutlet weak var piecesStack: UIStackView!
    
    @IBOutlet var Buttons: [UIButton]!
//    @IBOutlet var secondRowButtons: [UIButton]!
//    @IBOutlet var thirdRowButtons: [UIButton]!
//    @IBOutlet var fourthRowButtons: [UIButton]!
//    @IBOutlet var fifthRowButtons: [UIButton]!
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var game:gamesToInstall = gamesToInstall()
    
    
    
    var images:[[[Int]]] = []
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! CollectionViewCell
        let tetrisComp:tetrisComponent = tetrisComponent(parrentSize: cell.viewToPlaceImage.frame.size, list: images[indexPath.row], Color: FlatMint())
        for view in cell.viewToPlaceImage.subviews{
            view.removeFromSuperview()
        }
        if((indexPath.row % 2) == 1){
            cell.viewToPlaceImage.backgroundColor = primeColor
        }else{
            cell.viewToPlaceImage.backgroundColor = compositeColor
        }
        
        cell.viewToPlaceImage.addSubview(tetrisComp.myView)
        cell.list = images[indexPath.row]
        cell.myCollectionView = self.myCollectionView
        cell.myPiecesStack = self.piecesStack
        cell.myCreateDeckViewController = self
        cell.myIndexPath = indexPath
        //cell.viewToPlaceImage.
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        //images = self.game.getClasic()
        primeColor = FlatSand()
        compositeColor = FlatGray()
        fixButtonsAppearence()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        //primeColor = myChameleon.
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.nameTxtBox.text = self.name
        self.updateLabels()
        self.myCollectionView.reloadData()
    }
    @objc func dismissKeyboard() {
        self.nameTxtBox.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        selectButton(btn: sender)
        
    }
    
    
    
    @IBAction func donebtnPressed(_ sender: UIButton) {
        if(piecesLeft <= 0){
            if(piecesLeft < 0){
                let myAlert: UIAlertView = UIAlertView(title: "Warning! ", message: "You have more than 20 pieces in your deck, only the first 20 will be used!", delegate: self, cancelButtonTitle: "OK")
                    myAlert.show()
             }
            self.SaveAndExit()
        }else{
            let button2Alert: UIAlertView = UIAlertView(title: "Too Early", message: "You need another \(piecesLeft) to save your new deck", delegate: self, cancelButtonTitle: "OK")
            button2Alert.show()
        }
    }
    
    func selectButton(btn: UIButton){
        if(btn.backgroundColor == UIColor.flatBlack()){
            btn.backgroundColor = UIColor.flatWhite()
        }else{
            btn.backgroundColor = UIColor.flatBlack()
        }
        
    }
    

    func fixButtonsAppearence(){
        for button in Buttons{
            button.layer.borderColor = UIColor.flatGray().cgColor
            button.layer.borderWidth = 2
        }
    }
    
    
    
    @IBAction func addSquare(_ sender: UIButton) {
        addSquareToList()
    }
    
    @IBAction func clearSquares(_ sender: UIButton) {
        
        clearMySquares()
    }
    
    
    func addSquareToList(){
        if(self.checkIfNotEmpty()){
            var metr = 0
            var List:[[Int]] = [[],[],[],[],[]]
            for btn in Buttons{
                var row = metr / 5
                var cell = metr - (row * 5)
                if(btn.backgroundColor == UIColor.flatBlack()){
                    List[row].append(1)
                    self.squaresUsed = self.squaresUsed + 1
                }else{
                    List[row].append(0)
                }
                metr = metr + 1
            }
            self.images.append(List)
            self.myCollectionView.reloadData()
            
            self.clearMySquares()
            self.piecesLeft = self.piecesLeft - 1
            self.updateLabels()
            
            self.myCollectionView.reloadData()
            //self.myCollectionView.collectionViewLayout.invalidateLayout()
            
            
        }
    }
    
    
    func clearMySquares(){
        for btn in Buttons{
            btn.backgroundColor = UIColor.flatWhite()
        }
    }
    
    func checkIfNotEmpty() -> Bool{
        
        for btn in Buttons{
            if btn.backgroundColor == UIColor.flatBlack(){
                return true
            }
        }
        return false
    }
    
    func updateLabels(){
        lblPiecesLeft.text = "Pieces Left: \(self.piecesLeft)"
        lblSquaresUsed.text = "Squares Used: \(self.squaresUsed)"
        self.nameTxtBox.text = self.name
        
    }
    
    
    func SaveAndExit(){
        self.name = nameTxtBox.text!
        if(self.name == nil || self.name == ""){
            self.name = "No name"
        }
            var tmpDecks:[Deck] = []
            if let decksToReturn = NSKeyedUnarchiver.unarchiveObject(withFile: Deck.ArchiveURL.path) as? [Deck]{
                tmpDecks = decksToReturn
            }
            var date = NSDate().description
            date = fixDate(date: date)
            
            //print(date.s)
            var myNewDeck:Deck = Deck(n: self.name, List: self.images, numberOfP: 20, NumberofS: Int64(self.squaresUsed),d: date)
            tmpDecks.append(myNewDeck)
            let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(tmpDecks, toFile: Deck.ArchiveURL.path)
            if(isSuccesfulSave){
                print("Successfull Save")
            }else{
                print("Unsuccessfull Save")
            }
            print("Saving...")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            var LobbyDeckViewController:DecksLobbyViewController = storyBoard.instantiateViewController(withIdentifier: "DecksLobbyViewController") as! DecksLobbyViewController
            self.present(LobbyDeckViewController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func fixDate(date: String) ->String{
        var newStringtoReturn:String = ""
        for char in date{
            if(char == "+"){
                return newStringtoReturn
            }else{
                newStringtoReturn.append(char)
            }
        }
        return newStringtoReturn
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.myCollectionView.frame.height / 6 * 5, height: self.myCollectionView.frame.height / 6 * 5)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (self.myCollectionView.frame.height / 6 * 5) / 15
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
