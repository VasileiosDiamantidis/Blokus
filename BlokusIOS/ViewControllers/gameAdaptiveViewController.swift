//
//  gameAdaptiveViewController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 11/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit
import AudioToolbox
class gameAdaptiveViewController: UIViewController {

    var playerSurrenderedPositions:[Int] = []
    let xibSomeOneDisconnected:SomeOneDisconnected = UINib(nibName: "SomeOneDisconnected", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SomeOneDisconnected
    @IBOutlet weak var topLebel: UILabel!
    var ListOfAvailableSquares:[[Int]] = []
    var myPosition:Int!
    var pressedItem:tetrisComponent!
    var sqareSize: CGFloat!
    @IBOutlet weak var tStack: UIStackView!
    @IBOutlet weak var tImage: UIImageView!
    
    @IBOutlet weak var elementStack: UIStackView!
    @IBOutlet weak var btnSurrender: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var tmpViewTest: UIView!
    @IBOutlet weak var stackTmpTest: UIStackView!
    @IBOutlet weak var muteBtn: UIButton!
    
    var testView:UIView!
    var newView: UIView?
    var myPieces:[[tetrisComponent]] = [[]]
    var playedPiecesPositions:[[Int]] = []
    var myPiecesPositions:[[Int]] = []
    var myCornerPieceInitializer:[Int]!// = [1,1]
    var playedPiecesFromDeck:[[Int]]=[]
    var tmpPieceFromDeck:[Int]!
    var piecesPerPlayer = 20
    var playingFirstTime = true
    
    var numberOfRemainingPlayers = 4
    var listOfPlayersToShow:[Player] = []
    var numberOfSurrenders:Int = 0
    var askedToShowXib:Bool = false
    var gamePaused = false
    var appDeligate:AppDelegate!
    var waiting = false
    var countSecondsDisconnected:Int = 0
    
    //--------Variables that come from HostGameController--------------//
    
    var positionThatIPlay:Int!
    var mePlayer:Player!
    var gameMode:String!
    var gameTimePerRound:Int!
    var squaresPerSideOnImage:Int!
    //-----------------------------------------------------------------//
    
    var Playing:Bool = false
    var whoIsPlaying = 1
    var didntLoseYet = true
    var timer:Timer!
    var ListOfPeers:[MCPeerID]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //myPiecesPositions.append([1,1])
        testView = UIView()
        setCornerInitializer()
        var selfPlayer:Player = Player(name: self.mePlayer.name, score: self.mePlayer.score, color: self.mePlayer.color)
        self.listOfPlayersToShow.append(selfPlayer)
        //stackTmpTest.addArrangedSubview(testView)
        
        //myTetricePiece.centerPiece.includeMySquare(toAView: myTetricePiece.viewContainer)
        //var myTetricePiece:tetrisPieceView = tetrisPieceView(piecesPerSide: 3)
        //tmpViewTest = myTetricePiece.viewContainer
        initializeAppDeligate()
        if(positionThatIPlay == 1){
            Playing = true
            sendColorOfPlayingPlayer()
        }
        if(self.gameTimePerRound == nil){
            self.gameTimePerRound = -1
        }
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
        for peer in self.appDeligate.MulityPeerConnObj.session.connectedPeers{
            ListOfPeers.append(peer)
        }
    }
    
    
    
    var vibrationEnabled:Bool = true
    
    @IBAction func muteBtnPressed(_ sender: Any) {
        self.mute()
    }
    
    func mute(){
        if(vibrationEnabled){
            vibrationEnabled = false
            muteBtn.setTitle("UnMute", for: .normal)
        }else{
            vibrationEnabled = true
            muteBtn.setTitle("Mute", for: .normal)
        }
    }
    

    func setCornerInitializer(){
        topLebel.text = "Name \(self.mePlayer.name!), posThatIwillPlay: \(self.positionThatIPlay!)"
        switch self.positionThatIPlay {
        case 1:
            myCornerPieceInitializer = [1,1]
            break
        case 2:
            myCornerPieceInitializer = [squaresPerSideOnImage,1]
            break
        case 3:
            myCornerPieceInitializer = [1,squaresPerSideOnImage]
            break
        case 4:
            myCornerPieceInitializer = [squaresPerSideOnImage,squaresPerSideOnImage]
            break
        default:
            print("Default")
        }
        
        
        //myCornerPieceInitializer = [1,1]
    }
    override func viewDidAppear(_ animated: Bool) {
        //print(stackTmpTest.arrangedSubviews)
        //-----------TRASH---------------//
        /*print("Size: \(tmpViewTest.frame.size)")
        var myTetricePiece:tetrisPieceView = tetrisPieceView(view: tmpViewTest, piecesPerSide: 3, width: tmpViewTest.frame.width, height: tmpViewTest.frame.height)
        myTetricePiece.centerPiece.includeMySquare(toAView: self.tmpViewTest)
        myTetricePiece.centerPiece.addBotSquare(toAview: self.tmpViewTest)*/
        //-------------------------------//
        
        //var list:[[Int]] = [[0,0,0],[1,1,1],[0,0,0]]
        //var tetrisComp:tetrisComponent=tetrisComponent(parrentSize: self.tmpViewTest.frame.size, list: list)
        //tmpViewTest.addSubview(tetrisComp.myView)
        fillEverything()
        //myTetricePiece.centerPiece.addBotSquare(toAview: <#UIView#>)
        
        if(self.tImage.frame.width > self.tImage.frame.height){
            sqareSize = self.tImage.frame.height / CGFloat(squaresPerSideOnImage)
            self.tImage.frame.size = CGSize(width: self.tImage.frame.height, height: self.tImage.frame.height)
        }else{
            sqareSize = self.tImage.frame.width / CGFloat(squaresPerSideOnImage)
            self.tImage.frame.size = CGSize(width: self.tImage.frame.width, height: self.tImage.frame.width)
        }
        //self.tImage.center = self.tStack.center
        self.tImage.frame.origin.x = (self.tStack.frame.width / 2) - (self.tImage.frame.width / 2)
        //print("ImageWidth = \(tImage.frame.width)")
        //print("ImageHeight = \(tImage.frame.height)")
        addSquaresToImage()
        
        
        drawWithLowAlpha(squareToDrow: self.myCornerPieceInitializer)
        //Time
        if(self.gameTimePerRound > 0){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            self.reFillTimer()
        }
        self.initializeStatistics()
        
    }
    
    func reFillTimer(){
        if(self.gameTimePerRound > 0){
            self.lblTime.text = String(self.gameTimePerRound)
        }else{
            self.lblTime.text = String("no time")
        }
    }
    
    func stopTimer(){
        if(self.gameTimePerRound > 0){
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    @objc func updateTimer(){
//        if(!waiting){
//            checkSession()
//        }else{
//            checkReconnected()
//        }
//        if(gamePaused == false){
        var remainingTime:Int = Int(self.lblTime.text!)!
        remainingTime = remainingTime - 1
        if(remainingTime < 10){
            self.lblTime.backgroundColor = UIColor.red
        }else{
            self.lblTime.backgroundColor = UIColor.white
        }
        if(remainingTime < 0){
            if(Playing){
                surrender()
            }
            self.lblTime.text = String(0)
        }
        
        self.lblTime.text = String(remainingTime)
        
//        }
    }
    
    
    
    func addSquaresToImage(){
        var positionX:CGFloat = 0
        var positionY:CGFloat = 0
        for i in 0...self.squaresPerSideOnImage - 1{
            positionY = CGFloat(i) * self.sqareSize
            for j in 0...self.squaresPerSideOnImage - 1{
                positionX = CGFloat(j) * self.sqareSize
                var newView:UIImageView = UIImageView(frame: CGRect(x: positionX, y: positionY, width: self.sqareSize, height: self.sqareSize))
                newView.image = #imageLiteral(resourceName: "square")
                self.tImage.addSubview(newView)
                newView.isUserInteractionEnabled = false
            }
            
        }
    }
    
    
    func fillEverything(){
        var row:Int = 0;
        var game:gamesToInstall = gamesToInstall()
        var metr = 0
        for stack in elementStack.subviews{
            
        myPieces.append([])
        for view in stack.subviews{
            var List:[[[Int]]]!
            switch self.gameMode{
                case "Classic":
                    List = game.getClasic()
                    break
                case "Random":
                    List = game.getRandomPieces()
                    break
                case "DeckWar":
                    var SelectedDect:Deck!
                    if let deckToReturn = NSKeyedUnarchiver.unarchiveObject(withFile: Deck.ArchiveURLSelectedDeck.path) as? Deck{
                        SelectedDect = deckToReturn
                        List = SelectedDect.myListOfData
                    }else{
                        List = game.getClasic()
                    }
                    break
                default:
                    List = game.getClasic()
                    break
                
            }
            //var List:[[[Int]]] = game.getRandomPieces()
            //var list:[[Int]] = game.totalList[Int((arc4random_uniform(UInt32((game.totalList.count - 1)))))]
            var list = List[metr]
            metr = metr + 1
            var tetrisComp:tetrisComponent=tetrisComponent(parrentSize: self.tmpViewTest.frame.size, list: list, Color: self.mePlayer.color)
            view.addSubview(tetrisComp.myView) // isws na prepei na tis krathsw se ena array 'h to tetrisComp
            myPieces[row].append(tetrisComp)
        }
        row = row + 1
        }
        
    }
    
    
    
//    func fillEverythingDyanamic(){
//        var row:Int = 0;
//        var game:gamesToInstall = gamesToInstall()
//        var metr = 0
//
//        var rows = elementStack.subviews.count
//        var piecesPerRow = Int(piecesPerPlayer / rows)
//        var List:[[[Int]]] = game.getClasic()
//        for i in 0...rows - 1{
//            var horizontalStack = elementStack.subviews[i] as! UIStackView
//            myPieces.append([])
//            for j in 0...(piecesPerRow - 1) {
//
//                if(j>4){
//                var tmpNewView = UIView()
//                horizontalStack.addArrangedSubview(tmpNewView)
//                var list = List[metr]
//                metr = metr + 1
//                var tetrisComp:tetrisComponent=tetrisComponent(parrentSize: self.tmpViewTest.frame.size, list: list)
//                tmpNewView.addSubview(tetrisComp.myView)
//                myPieces[row].append(tetrisComp)
//
//                }
//                else{
//                    var list = List[metr]
//                    metr = metr + 1
//                    var tetrisComp:tetrisComponent=tetrisComponent(parrentSize: self.tmpViewTest.frame.size, list: list)
//                    horizontalStack.subviews[j].addSubview(tetrisComp.myView) // isws na prepei na tis krathsw se ena array 'h to tetrisComp
//                    myPieces[row].append(tetrisComp)
//                }
//                row = row + 1
//            }
//        }
    //}
    
    var checkIfitsJustAclick:Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if(gamePaused == false){
        if(Playing && didntLoseYet){
        var touch:UITouch = touches.first!
        var loc = touch.location(in: self.tImage)
        //print("location In image: \(loc)")
        var loc2 = touch.location(in: self.tStack)
        //print("location In image: \(loc2)")
        
        //This is only for rotation if he taps 2 times---
        if(touches.count > 1){
            if(pressedItem != nil){
                if(newView != nil){
                    pressedItem.rotateSelf()
                    newView?.layer.anchorPoint = CGPoint(x: 0.5,y: 0.5)
                    newView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                }
            }
        }
        //---------------------------------------------
        
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            
            if hitView == elementStack{
                checkIfitsJustAclick = true
                var tmpArr:[Int] = getRowPosition(touch: touch)
                var row:Int = tmpArr[0]
                var pos:Int = tmpArr[1]
                
                var tetrisElementPressed = myPieces[row - 1][pos - 1]
                if(isntPlaced(row: row - 1,col: pos - 1)){
                    tmpPieceFromDeck = [row - 1, pos - 1]
                
                pressedItem = tetrisElementPressed
                var center = self.view.convert(tetrisElementPressed.myView.center, from: elementStack.subviews[row - 1].subviews[pos - 1])
                pressedItem.previousPosition = center
                pressedItem.previousSize = pressedItem.myView.frame.size
                changeSize(pressedItem)
                if(newView != nil){
                    newView?.center = (touches.first?.location(in: self.view))!
                }
                
                }
                //self.view.addSubview(pressedItem.myView)
                //pressedItem.moveToLocation(location: (touches.first?.location(in: self.view))!)
            } else {
                print("touch is outside")
            }
            
        
        
//            }
        
            }}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if(gamePaused == false){
        if(Playing && didntLoseYet){
        checkIfitsJustAclick = false
        if(pressedItem != nil){
            //pressedItem.moveToLocation(location: (touches.first?.location(in: self.view))!)
            var location:CGPoint = CGPoint(x: (touches.first?.location(in: self.view))!.x,y: (touches.first?.location(in: self.view))!.y - (self.view.frame.height / 5))
            newView?.center = location
            }}
        
//    }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if(gamePaused == false){
        if(Playing && didntLoseYet){
        if pressedItem != nil{
            if(checkIfitsJustAclick == true){
                pressedItem.rotateSelf()
                checkIfitsJustAclick = false
            }
            
        self.pressedItem.myView.isHidden = false
        if let firstTouch = touches.first {
            var location:CGPoint = CGPoint(x: (touches.first?.location(in: self.view))!.x,y: (touches.first?.location(in: self.view))!.y - (self.view.frame.height / 5))
            
            let hitView = self.view.hitTest(location, with: event)
            
            //if hitView == tStack{
            
            var loc:CGPoint = CGPoint(x: (touches.first?.location(in: self.tImage))!.x,y: (touches.first?.location(in: self.tImage))!.y - (self.view.frame.height / 5))
            
            if(loc.x >= 0 && loc.y >= 0) && (loc.x <= self.tImage.frame.width && loc.y <= self.tImage.frame.height){
                var squareThatUserLeftTheTetris:[Int] = getCenterSquare(loc: loc)
                var rowLeftTheCenter = squareThatUserLeftTheTetris[0]
                var colLeftTheCenter = squareThatUserLeftTheTetris[1]
                if(checkIfIcanLeaveItHere(rowLeftTheCenter: rowLeftTheCenter, colLeftTheCenter: colLeftTheCenter)){ //TODO call and write the function to check if it's ok
                    
                    var listOfSquaresThatPlaced = getSquaresToPlace(rowLeftTheCenter: rowLeftTheCenter,colLeftTheCenter: colLeftTheCenter,pressedItem: pressedItem)
//                    print("-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-")
//                    print(listOfSquaresThatPlaced)
//                    print("-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-")
                    playedPiecesFromDeck.append(tmpPieceFromDeck)
                    //Edw kanw to send!!! TODO
                    pressedItem.myView.isUserInteractionEnabled = false
                    pressedItem.myView.isHidden = true
                    pressedItem.myView.removeFromSuperview()
                    pressedItem.myView.superview?.isUserInteractionEnabled = false
//                    for view in elementStack.subviews[0].subviews[0].subviews{
//                        view.removeFromSuperview()
//                    }
                    highlightAvailable()
                }
                //pressedItem.returnToPreviousPostion()
                
                 // this function willtell me in which square the user left the element
//                if(checkIfOK()){
//                    //place
//                }else{
//                    pressedItem.myView.isHidden == false
//
//                }
            //}
            }
        }
        self.newView?.removeFromSuperview()
        
            pressedItem = nil
        }
            }}
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //stackTmpTest.addSubview(myTetricePiece.viewContainer)
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func surrenderPressed(_ sender: Any) {
        self.surrender()
        
    }
    
    @IBAction func ScoreBtnPressed(_ sender: UIButton) {
        self.showXib()
        //sendAskForYourPoints()
        
    }
    
    func initializeStatistics(){
            let messageToSend = ["MyStatisticsNow": ["Name": self.mePlayer.name, "Points": self.mePlayer.score, "color": colorPalete.getStringFromColor(color: self.mePlayer.color)]]
            sendAMessage(messageToSend)
    }
    
    func sendAskForYourPoints(){
        let messageDict = ["sendAskForYourPoints":true]
        sendAMessage(messageDict)
    }
    
    func showXib(){
        //self.orderPlayersTosShow()
        
        //self.listOfPlayersToShow.sorted(by: { $0.score > $1.score})
        let xibQuote:showScore = UINib(nibName: "showScore", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! showScore
        
        
        xibQuote.p1[0].backgroundColor = listOfPlayersToShow[0].color
        xibQuote.p1[1].text = listOfPlayersToShow[0].name
        xibQuote.p1[2].text = listOfPlayersToShow[0].score.description
        
        
        xibQuote.p2[0].backgroundColor = listOfPlayersToShow[1].color
        xibQuote.p2[1].text = listOfPlayersToShow[1].name
        xibQuote.p2[2].text = listOfPlayersToShow[1].score.description
        
        xibQuote.p3[0].backgroundColor = listOfPlayersToShow[2].color
        xibQuote.p3[1].text = listOfPlayersToShow[2].name
        xibQuote.p3[2].text = listOfPlayersToShow[2].score.description
        
        xibQuote.p4[0].backgroundColor = listOfPlayersToShow[3].color
        xibQuote.p4[1].text = listOfPlayersToShow[3].name
        xibQuote.p4[2].text = listOfPlayersToShow[3].score.description
        //xibQuote.quote.attributedText = myString
        
        //xibQuote.frame.size.height = myString.heightWithConstrainedWidth(width: xibQuote.quote.frame.size.width - 47)
        xibQuote.frame = CGRect(x: self.view.frame.width / 10, y: self.tImage.frame.height, width: (self.view.frame.width / 10) * 9, height: (self.view.frame.width / 10) * 9)
        xibQuote.center = self.view.center
        
        self.view.addSubview(xibQuote)
        
        self.askedToShowXib = false
    }
    
    func gameEnded(){
        self.sendGameEnded()
        self.stopTimer()
        showFinishXIB()
    }
   
    func sendGameEnded(){
        let messageDict = ["gameFinished":true]
        sendAMessage(messageDict)
    }
    
    func showFinishXIB(){
        self.Playing = false
        let xibResults:results = UINib(nibName: "results", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! results
        
        for i in 0...self.listOfPlayersToShow.count - 1{
            for j in 0...self.listOfPlayersToShow.count - 1{
                if(listOfPlayersToShow[i].comparePoints(opponent: listOfPlayersToShow[j])){
                    var tmpP:Player = listOfPlayersToShow[i]
                    listOfPlayersToShow[i] = listOfPlayersToShow[j]
                    listOfPlayersToShow[j] = tmpP
                }
            }
        }
        
        xibResults.fourth[1].text = listOfPlayersToShow[3].name
        xibResults.fourth[1].backgroundColor = listOfPlayersToShow[3].color
        xibResults.fourth[2].text = listOfPlayersToShow[3].score.description
        xibResults.fourth[2].backgroundColor = listOfPlayersToShow[3].color
        
        xibResults.third[1].text = listOfPlayersToShow[2].name
        xibResults.third[1].backgroundColor = listOfPlayersToShow[2].color
        xibResults.third[2].text = listOfPlayersToShow[2].score.description
        xibResults.third[2].backgroundColor = listOfPlayersToShow[2].color
        
        xibResults.second[1].text = listOfPlayersToShow[1].name
        xibResults.second[1].backgroundColor = listOfPlayersToShow[1].color
        xibResults.second[2].text = listOfPlayersToShow[1].score.description
        xibResults.second[2].backgroundColor = listOfPlayersToShow[1].color
        
        xibResults.winner[1].text = listOfPlayersToShow[0].name
        xibResults.winner[1].backgroundColor = listOfPlayersToShow[0].color
        xibResults.winner[2].text = listOfPlayersToShow[0].score.description
        xibResults.winner[2].backgroundColor = listOfPlayersToShow[0].color
        
        xibResults.gVC = self
        xibResults.frame = CGRect(x: self.view.frame.width / 10, y: self.tImage.frame.height, width: (self.view.frame.width / 10) * 9, height: (self.view.frame.width / 10) * 9)
        xibResults.center = self.view.center
        
        self.view.addSubview(xibResults)
        
    }
}






extension gameAdaptiveViewController{
    
    func getRowPosition(touch: UITouch) -> [Int]{
        var absMinX:CGFloat = 10000
        var absMinY:CGFloat = 10000
        var row:Int = 0
        var pos:Int = 0
        
        var location = touch.location(in: self.view)
        //print("Location in view \(location)")
        var countRows:Int = 0
        var countPositions:Int = 0
        for stack in elementStack.subviews{
            countRows = countRows + 1
            //print("Location in elementStack subview \(touch.location(in: stack))")
            var touchLocationy = touch.location(in: stack).y - (stack.frame.height / 2)
            if(abs(touchLocationy) <= abs(absMinY)){
                absMinY = touchLocationy
                row = countRows
            }
            countPositions = 0
            for view in stack.subviews{
                countPositions = countPositions + 1
                var touchLocationx = touch.location(in: view).x - (view.frame.width / 2)
                //print("Location in stacks subview \(touch.location(in: view))")
                if(abs(touchLocationx) <= absMinX){
                    absMinX = touchLocationx
                    pos = countPositions
                }
            }
            print("---------End of stack subview-------------")
        }
        
        //print("absMinY = \(absMinY)")
        //print("absMinX = \(absMinX)")
        //print("Row: \(row) Pos: \(pos)")
    
        return [row,pos]
    }
    
    
    func changeSize(_ pressedItem: tetrisComponent){
        //var width = self.tImage.frame.width / 10
//        print("ImageWidthNew = \(tImage.frame.width)")
//        print("ImageHeightNew = \(tImage.frame.height)")
        self.newView = UIView(frame: CGRect(x:pressedItem.myView.frame.origin.x ,y:pressedItem.myView.frame.origin.x,width: sqareSize * CGFloat(pressedItem.horizontalSquares),height: sqareSize * CGFloat(pressedItem.verticalSquares)))
        //newView?.backgroundColor = UIColor.darkGray
//        print("newView.width = \(newView?.frame.width)")
//        print("newView.height = \(newView?.frame.height)")
        createSquares(list: pressedItem.myList, size: self.sqareSize, view: self.newView!)
        self.view.addSubview(self.newView!)
        self.pressedItem.myView.isHidden = true
    }
    
    
    func createSquares(list:[[Int]],size:CGFloat,view:UIView){
        //var squareSize:CGFloat = size
        
        
        var squareView = UIView(frame: CGRect(x: 0, y: 0, width: self.sqareSize, height: self.sqareSize))
        
        for i in 0...list.count - 1{
            for j in 0...list[i].count - 1{
                var x = CGFloat(j) * self.sqareSize
                var y = CGFloat(i) * self.sqareSize
                if(list[i][j] == 1){
                    var squareView = UIView(frame: CGRect(x: x, y: y, width: self.sqareSize, height: self.sqareSize))
                    squareView.backgroundColor = mePlayer.color
                    squareView.layer.borderColor = UIColor.black.cgColor
                    squareView.layer.borderWidth = 1
                    view.addSubview(squareView)
                }
            }
        }
        
        
    }
    
    
    func getCenterSquare(loc:CGPoint) -> [Int]{
        var str = ""
        for row in 0...squaresPerSideOnImage{
            for position in 0...squaresPerSideOnImage{
                var pointerX = CGFloat(position) * sqareSize
                var pointerY = CGFloat(row) * sqareSize
                if((pointerX > loc.x) && ((pointerX - sqareSize) < loc.x)){
                    if((pointerY > loc.y) && ((pointerY - sqareSize) < loc.y)){
                        //print("Position in Image = \(row)\(position)")
                        return [row,position]
                    }
                }
            }
        }
        return [0,0]
    }
    
    
    
    func getSquaresToPlace(rowLeftTheCenter: Int,colLeftTheCenter: Int,pressedItem:tetrisComponent){
        var listOfSquares:[[Int]] = pressedItem.giveMeYourSquaresBasedOnPatternFixed(rowLeftTheCenter: rowLeftTheCenter,colLeftTheCenter: colLeftTheCenter)
        self.mePlayer.score = self.mePlayer.score + listOfSquares.count
        //print()
        drawSquares(listOfSquares: listOfSquares,Color: self.mePlayer.color)
        //Edw einai h lista me tis theseis poy grafontai sto terrain me vash th thesh toy paikth
        sendSquares(listOfSquares: listOfSquares, color : self.mePlayer.color)
        
        for peice in listOfSquares{
            playedPiecesPositions.append(peice)
        }
        for peice in listOfSquares{
            myPiecesPositions.append(peice)
        }
        //SendSqareusThatIPlayed
        
    }
    
    
    func drawSquares(listOfSquares: [[Int]],Color: UIColor){
        for place in listOfSquares{
            var originY = CGFloat((place[0] - 1)) * self.sqareSize
            var originX = CGFloat((place[1] - 1)) * self.sqareSize
            var sqareToPlace:UIView = UIView(frame: CGRect(x: originX,y: originY, width: self.sqareSize, height: self.sqareSize))
            sqareToPlace.layer.borderWidth = 1
            sqareToPlace.layer.borderColor = UIColor.black.cgColor
            sqareToPlace.backgroundColor = Color
            self.tImage.addSubview(sqareToPlace)
        }
    }
    
    func checkIfIcanLeaveItHere(rowLeftTheCenter:Int, colLeftTheCenter:Int) ->Bool{
        var listOfSquares:[[Int]] = pressedItem.giveMeYourSquaresBasedOnPatternFixed(rowLeftTheCenter: rowLeftTheCenter,colLeftTheCenter: colLeftTheCenter)
        var foundDiagnal = false
        for place in listOfSquares{
            if(place[0] > squaresPerSideOnImage){
                return false
            }
            if(place[1] > squaresPerSideOnImage){
                return false
            }
            if(place[0] <= 0){
                return false
            }
            if(place[1] <= 0){
                return false
            }
            
        }
        for place in listOfSquares{
            if (playingFirstTime == true) {
                if((passesFirstSquareCheck(listOfSquares: listOfSquares) == true)){
                    playingFirstTime = false
                    return true
                }else{
                    return false
                }}
            if hasDiagnalSquare(listOfSquares: listOfSquares) == false{
                return false
            }
            if connectsWithHisSquare(listOfSquares: listOfSquares) == true{
                return false
            }
            if checkIfItsUponSomeSquare(listOfSquares: listOfSquares) == true{
                return false
            }
            
        }
        
        return true
    }
    
    
    func passesFirstSquareCheck(listOfSquares:[[Int]]) -> Bool{
        for place in listOfSquares{
            if (place[0] == myCornerPieceInitializer[0] && place[1] == myCornerPieceInitializer[1]){
                return true
            }
        }
        
        
        return false
    }
    
    func hasDiagnalSquare(listOfSquares:[[Int]]) -> Bool{
        for place in listOfSquares{
            var listToCheckLeft = place
            listToCheckLeft[0] = listToCheckLeft[0] - 1
            listToCheckLeft[1] = listToCheckLeft[1] - 1
            var listToCheckRight = place
            listToCheckRight[0] = listToCheckRight[0] - 1
            listToCheckRight[1] = listToCheckRight[1] + 1
            var listToCheckTop = place
            listToCheckTop[0] = listToCheckTop[0] + 1
            listToCheckTop[1] = listToCheckTop[1] - 1
            var listToCheckBot = place
            listToCheckBot[0] = listToCheckBot[0] + 1
            listToCheckBot[1] = listToCheckBot[1] + 1
            
            for item in self.myPiecesPositions{
                if(item[0] == listToCheckLeft[0] && item[1] == listToCheckLeft[1]){
                    return true
                }
                if(item[0] == listToCheckRight[0] && item[1] == listToCheckRight[1]){
                    return true
                }
                if(item[0] == listToCheckTop[0] && item[1] == listToCheckTop[1]){
                    return true
                }
                if(item[0] == listToCheckBot[0] && item[1] == listToCheckBot[1]){
                    return true
                }
        }
            
    }
        return false
    }
    
    
    func connectsWithHisSquare(listOfSquares:[[Int]]) -> Bool{
        for place in listOfSquares{
            var listToCheckLeft = place
            listToCheckLeft[0] = listToCheckLeft[0] - 1
            var listToCheckRight = place
            listToCheckRight[0] = listToCheckRight[0] + 1
            var listToCheckTop = place
            listToCheckTop[1] = listToCheckTop[1] - 1
            var listToCheckBot = place
            listToCheckBot[1] = listToCheckBot[1] + 1
            
            for item in self.myPiecesPositions{
                if(item[0] == listToCheckLeft[0] && item[1] == listToCheckLeft[1]){
                    return true
                }
                if(item[0] == listToCheckRight[0] && item[1] == listToCheckRight[1]){
                    return true
                }
                if(item[0] == listToCheckTop[0] && item[1] == listToCheckTop[1]){
                    return true
                }
                if(item[0] == listToCheckBot[0] && item[1] == listToCheckBot[1]){
                    return true
                }
            }
            
        }
        return false
    }
    
    
    func checkIfItsUponSomeSquare(listOfSquares:[[Int]]) -> Bool{
            for place in listOfSquares{
                for terrainPlayedPlace in self.playedPiecesPositions{
                    if((place[0] == terrainPlayedPlace[0]) && (place[1] == terrainPlayedPlace[1])){
                        return true
                    }
                }
                
            }
        return false
    }
    
    func isntPlaced(row: Int,col: Int) -> Bool{
        for usedItem in self.playedPiecesFromDeck{
            if(usedItem[0] == row && usedItem[1] == col){
                return false
            }
        }
        return true
    }
    
}

import MultipeerConnectivity
extension gameAdaptiveViewController{
    //TODO
    //In this extension the game will be initiallizing (differenct tetris elements etc.. )
    
    
    
    func initializeAppDeligate(){
            appDeligate = UIApplication.shared.delegate as! AppDelegate
        }
    
    
    func sendAMessage(_ messageDict: Dictionary<String, Any>){
        do{
            let messageData = try JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            try appDeligate.MulityPeerConnObj.session.send(messageData, toPeers: appDeligate.MulityPeerConnObj.session.connectedPeers, with: MCSessionSendDataMode.reliable)
            //print("Send Hit \(strThatAttakerhit)")
            
        }catch{
            print(error)
        }
        var error:NSError
    }
    
    func addPointsToPlayerInMenu(name:String, points: Int){
        for p in self.listOfPlayersToShow{
            if(p.name == name){
                p.score = p.score + points
            }
        }
    }
    
    @objc func handleReceiveDataWithNotification(notification: NSNotification){
        //let userInfo = NSDictionary(dictionary: notification.userInfo!)
        let userInfo = notification.userInfo! as Dictionary
        let receivedData:NSData = userInfo["data"] as! NSData
        do{
            let message = try JSONSerialization.jsonObject(with: receivedData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            //let senderPeerId:MCPeerID = userInfo["PeerID"] as! MCPeerID
            //let senderDisplayName = senderPeerId.displayName
            if (message.object(forKey: "IPlayed") != nil){
                var someOnePlayed:NSDictionary = message.object(forKey: "IPlayed") as! NSDictionary
                var Squares:[[Int]] = someOnePlayed.object(forKey: "Squares") as! [[Int]]
                var color:String = someOnePlayed.object(forKey: "color") as! String
                var name:String = someOnePlayed.object(forKey: "name") as! String
                self.addPointsToPlayerInMenu(name: name,points: Squares.count)
                self.whoIsPlaying = someOnePlayed.object(forKey: "WhoIsPlaying") as! Int
                self.topLebel.text = "Hrthe na paiksei o \(whoIsPlaying) eimai o \(self.positionThatIPlay!)"
                acceptWhoIsPlaying()
                drawSquares(listOfSquares: Squares,Color: colorPalete.getColorFromString(color: color))
                self.topLebel.text = "\(self.topLebel.text!) drow"
                for peice in Squares{
                    playedPiecesPositions.append(peice)
                }
                self.topLebel.text = "\(self.topLebel.text!) append "
            }
            
            if (message.object(forKey: "ColorOfPlayer") != nil){
                var color:String = message.object(forKey: "ColorOfPlayer") as! String
                self.topLebel.backgroundColor = colorPalete.getColorFromString(color: color)
            }
            if (message.object(forKey: "Surrender") != nil){
                var positionLoser:Int = message.object(forKey: "Surrender") as! Int
                print("Hrthe Surrender positionLoser \(positionLoser)")
                print("Hrthe Surrender positionThatIPlay =  \(positionLoser)")
                if(positionLoser < self.positionThatIPlay){
                    self.positionThatIPlay = self.positionThatIPlay - 1
                    self.whoIsPlaying = self.whoIsPlaying - 1
                }
                print("Meta to If positionLoser \(positionLoser)")
                print("Meta to If positionThatIPlay =  \(positionLoser)")
                self.playerSurrenderedPositions.append(positionLoser)
                self.numberOfRemainingPlayers = self.numberOfRemainingPlayers - 1
                self.numberOfSurrenders = numberOfSurrenders + 1
                checkWhoIsPlaying()
                
            }
            
//            if (message.object(forKey: "sendAskForYourPoints") != nil){
//
//            }
            
            if (message.object(forKey: "MyStatisticsNow") != nil){
                
                var someoneStatistics:NSDictionary = message.object(forKey: "MyStatisticsNow") as! NSDictionary
                var someOneName:String = someoneStatistics.object(forKey: "Name") as! String
                var someOnePoints:Int = someoneStatistics.object(forKey: "Points") as! Int
                var someOneColor:String = someoneStatistics.object(forKey: "color") as! String
                var p = Player(name: someOneName, score: someOnePoints, color: colorPalete.getColorFromString(color: someOneColor))
                listOfPlayersToShow.append(p)
                
                
            }
            
            if(message.object(forKey: "gameFinished") != nil){
                var gameFinished:Bool = message.object(forKey: "gameFinished") as! Bool
                self.showFinishXIB()
            }
            
            
        }catch{
            print(error)
        }
        
    }
    
    
    
    func sendSquares(listOfSquares: [[Int]],color: UIColor){
        self.reFillTimer()
        self.Playing = false
        checkWhoIsPlaying()
        let messageDict = ["IPlayed":["name": self.mePlayer.name,"Squares" : listOfSquares, "color" : self.mePlayer.colorName,"WhoIsPlaying" : whoIsPlaying]]
        
       self.addPointsToPlayerInMenu(name: self.mePlayer.name,points: listOfSquares.count)
        
        sendAMessage(messageDict)
        
        
        
    }
    
    func checkWhoIsPlaying(){
        whoIsPlaying = whoIsPlaying + 1
        print("checkWhoIsPlaying \(whoIsPlaying)")
        print("checkWhoIsPlaying =  \(numberOfRemainingPlayers)")
        if(whoIsPlaying > self.numberOfRemainingPlayers){
            whoIsPlaying = 1
        }
        //var loops:Int = 0
//        while(playerSurrenderedPositions.contains(whoIsPlaying) == true){
//            loops = loops + 1
//            whoIsPlaying = whoIsPlaying + 1
//            if(whoIsPlaying > 4){
//                whoIsPlaying = 1
//            }
//
//            if(loops > 20){
//                return
//            }
//        }
        acceptWhoIsPlaying()
    }
    
    func acceptWhoIsPlaying(){
        print("checkWhoIsPlaying \(whoIsPlaying)")
        print("checkWhoIsPlaying =  \(self.positionThatIPlay)")
        if(whoIsPlaying == self.positionThatIPlay){
            self.Playing = true
            if(vibrationEnabled){
               AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
            sendColorOfPlayingPlayer()
            self.topLebel.text = "\(self.topLebel.text!) if "
        }
        self.reFillTimer()
    }
    
    
    func getColorFromString(color: String) ->UIColor{
        switch color {
        case "Blue":
            return UIColor.blue
        case "Red":
            return UIColor.red
        case "Yellow":
            return UIColor.yellow
        case "Green":
            return UIColor.green
        default:
            return self.mePlayer.color
        }
    }
    
    
    func getStringFromColor(color: UIColor) ->String{
        switch color {
        case UIColor.blue:
            return "Blue"
        case UIColor.red:
            return "Red"
        case UIColor.yellow:
            return "Yellow"
        case UIColor.green:
            return "Green"
        default:
            return "Blue"
        }
    }
    
    func sendColorOfPlayingPlayer(){
    let messageDict = ["ColorOfPlayer": self.mePlayer.colorName]
    sendAMessage(messageDict)
        self.topLebel.backgroundColor = self.mePlayer.color
    
    }
    
    
}


extension gameAdaptiveViewController{
    
    
    
    func highlightAvailable(){
        
        self.removeHighLighted(oldListOfHighlighted: self.ListOfAvailableSquares)
        self.ListOfAvailableSquares.removeAll()
        for squareThatIhavePlaced in self.myPiecesPositions{
            var topLeft:[Int] = [squareThatIhavePlaced[0] - 1,squareThatIhavePlaced[1] - 1]
            var topRight:[Int] = [squareThatIhavePlaced[0] - 1,squareThatIhavePlaced[1] + 1]
            var botLeft:[Int] = [squareThatIhavePlaced[0] + 1,squareThatIhavePlaced[1] - 1]
            var botRight:[Int] = [squareThatIhavePlaced[0] + 1,squareThatIhavePlaced[1] + 1]
            //var availableS:[Int] = giveMeAvailableSquares(square: topLeft)
            
            var ListOfElements:[[Int]] = [topLeft,topRight,botLeft,botRight]
            
            for s in ListOfElements{
                if hasDiagnalSquare(listOfSquares: [s]) == true && (connectsWithHisSquare(listOfSquares: [s]) == false) && (checkIfItsUponSomeSquare(listOfSquares: [s]) == false && s[0] > 0 && s[1] > 0 && s[0] <= self.squaresPerSideOnImage && s[1] <= self.squaresPerSideOnImage){
                    ListOfAvailableSquares.append(s) //Edw mporoume na to kanoyme apeytheias highlight
                }
            }
        }
        
        for squareToHighLight in ListOfAvailableSquares{
            
            drawWithLowAlpha(squareToDrow: squareToHighLight)
        }
    }
    
    func drawWithLowAlpha(squareToDrow: [Int]){
        var color = self.mePlayer.color
        let newColor = color?.withAlphaComponent(0.2)
        drawSquares(listOfSquares: [squareToDrow], Color: newColor!)
    }
    
    
    func removeHighLighted(oldListOfHighlighted: [[Int]]){
        drawSquares(listOfSquares: oldListOfHighlighted, Image: #imageLiteral(resourceName: "square"))
    }
    
    
    func drawSquares(listOfSquares: [[Int]],Image: UIImage){
        for place in listOfSquares{
            if(checkIfItsUponSomeSquare(listOfSquares: [place]) == false){
                var originY = CGFloat((place[0] - 1)) * self.sqareSize
                var originX = CGFloat((place[1] - 1)) * self.sqareSize
                var sqareToPlace:UIImageView = UIImageView(frame: CGRect(x: originX,y: originY, width: self.sqareSize, height: self.sqareSize))
                sqareToPlace.image = #imageLiteral(resourceName: "square")
                sqareToPlace.layer.borderWidth = 1
                sqareToPlace.layer.borderColor = UIColor.black.cgColor
                //sqareToPlace.backgroundColor = Color
                //sqareToPlace.image
                self.tImage.addSubview(sqareToPlace)
            }}
    }
    
    
    
}


extension gameAdaptiveViewController{
    
    func surrender(){
        if(Playing){
            self.reFillTimer()
            self.Playing = false
            self.sendILostWithMyPosition(position: self.positionThatIPlay)
            self.positionThatIPlay = -1
            btnSurrender.isEnabled = false
            btnSurrender.isHidden = true
            self.didntLoseYet = false
            if(numberOfSurrenders == 3){
                self.gameEnded()
            }
            //Isws edw mporw na valw kai send ta pionia moy gia na xanoun ligo alpa me to xrwma moy
        }
    }
    
    func sendILostWithMyPosition(position: Int){
        let messageDict = ["Surrender":position]
        sendAMessage(messageDict)
    }
    
    
    
    
    
    
}



extension gameAdaptiveViewController: MCSessionDelegate{
    
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        switch state.rawValue {
            case 0:
                print("Disconnected")
                break
            case 1:
                print("Connecting")
                break
            case 2:
                print("Connected")
                break
            default:
                print("Default")
            }
        
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("Loco")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("Loco")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Loco")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("Loco")
    }
    


}

//extension gameAdaptiveViewController: MCBrowserViewControllerDelegate {
//    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
//
//    }
//
//    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
//
//    }
//
//
//    func checkSession(){
//        if(self.appDeligate.MulityPeerConnObj.session.connectedPeers.count <= 3){
//            countSecondsDisconnected = countSecondsDisconnected + 1
//            if((countSecondsDisconnected > 5) && (self.waiting == false)){
//            self.waitPlayer()
//            self.waiting = true
//            countSecondsDisconnected = 0
//            }
//        }else{
//            countSecondsDisconnected = 0
//        }
//    }
//
//
//
//    func checkReconnected(){
//        if(self.appDeligate.MulityPeerConnObj.session.connectedPeers.count > 0){
//            self.appDeligate.MulityPeerConnObj.advertiseSelf(advertise: true)
//        }else{
//            NotificationCenter.default.addObserver(self, selector: #selector(peerChangedStateWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
//                //self.IsendMyName = false
//                //sendIamVisible(false)
//                if appDeligate.MulityPeerConnObj.session != nil{
//                appDeligate.MulityPeerConnObj.advertiseSelf(advertise: true)
//                appDeligate.MulityPeerConnObj.setupBrowser()
//                appDeligate.MulityPeerConnObj.browser.delegate = self
//                self.appDeligate.MulityPeerConnObj.advertizer!.stop()
//                self.appDeligate.MulityPeerConnObj.advertizer = nil
//                //appDeligate.MulityPeerConnObj.browser.modalPresentationStyle = UIModalPresentationStyle
//                self.present(appDeligate.MulityPeerConnObj.browser, animated:true, completion:nil)
//            }
//        }
//
//        if(self.appDeligate.MulityPeerConnObj.session.connectedPeers.count == 3){
//            self.playerRecconnected()
//            self.waiting = false
//            }
//
//    }
//
//
//
//
//    func waitPlayer(){
//        self.gamePaused = true
//        self.xibSomeOneDisconnected.InitializeMyImage()
//        self.xibSomeOneDisconnected.center = self.view.center
//        self.view.addSubview(self.xibSomeOneDisconnected)
//    }
//
//    func playerRecconnected(){
//        self.gamePaused = false
//        self.xibSomeOneDisconnected.RemoveMe()
//    }
//
//    @objc func peerChangedStateWithNotification(notification: NSNotification){
//        let userInfo = NSDictionary(dictionary: notification.userInfo!)
//        let state = userInfo.object(forKey: "state") as! String
//        let intState = Int(state)
//        if intState != MCSessionState.connecting.rawValue {
//            //self.navigationItem.title = "Connected"
//            //self.sendMyName()
//
//            //Edw ginetai initialize to game kai apo tis 1 meries
//        }
//    }
//
//
//}





