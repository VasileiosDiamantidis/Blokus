//
//  HostGameViewController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 13/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import DropDown

class HostGameViewController: UIViewController {

    
    var topColor:String = "Blue"
    var botColor:String = "Yellow"
    var leftColor:String = "Green"
    var rightColor:String = "Red"
    
    var colorsToDisable:[String] = []
    
    
    var appDeligate:AppDelegate!
    
    @IBOutlet weak var ExitBtn: UIButton!
    var Host:Bool = true
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var terrainSizeBtn: UIButton!
    @IBOutlet weak var timeSizeBtn: UIButton!
    
    //@IBOutlet weak var secondPlayerName: UILabel!
    
    @IBOutlet weak var stackViewToExitIfnotHost: UIStackView!
    
    @IBOutlet weak var stackViewGameInfo: UIStackView!
    
    @IBOutlet weak var txtFieldName: UITextField!
    
    var players:[Player] = []
    //var PreviousName:String!
    
   // var playersHere:[Player] = []
    var dropDownTime:DropDown!
    var dropDownTerrain:DropDown!
    
    @IBOutlet weak var LabelTop: UILabel!
    @IBOutlet weak var LabelBot: UILabel!
    
    @IBOutlet weak var LabelRight: UILabel!
    @IBOutlet weak var LabelLeft: UILabel!
    
    var LabelPositions = [1,0,0,0]
    var namesLabels:[UILabel] = []
    
    @IBOutlet weak var deckWar: UIButton!
    
    var seconds = 0
    
    @IBOutlet weak var btnClasicMode: UIButton!
    @IBOutlet weak var btnRandomMode: UIButton!
    //@IBOutlet weak var txtBoxTerrainSize: UITextField!
    @IBOutlet weak var lblTerrainSize: UILabel!
    //@IBOutlet weak var txtBoxTimePerRound: UITextField!
    @IBOutlet weak var lblTimePerRound: UILabel!
    
    var selectedtextField:UITextField!
    //game Properties
    var gameMode:String = "Classic"
    var gameTerrainSize:Int = 20
    var gameTimePerRound:Int = 30
    //var timer:Timer!
    
    var myTerrainSelectedSize:Int = 20
    var myTimePerRoundDuration:Int = 30
    
    override func viewDidLoad() {
        
        //self.txtFieldName.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
        
        super.viewDidLoad()
        addCornerRadiusToLabels()
        namesLabels = [LabelTop,LabelBot,LabelLeft,LabelRight]
        if(Host == false){
            appDeligate = UIApplication.shared.delegate as! AppDelegate
            sendSomeOneJoined(name: "") //Stelnw name ktl gia na me metrhsei meta
            self.txtFieldName.text = savedUserName.loadName()
            
            //self.PreviousName = "player \(self.appDeligate.MulityPeerConnObj.session.connectedPeers.count + 1)"
            NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
        }
        
        
        if(Host == true){
            
        initializeAppDeligate(name: "player 1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(peerChangedStateWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
            print(self.appDeligate.MulityPeerConnObj.peerID.description)
            self.LabelTop.text = "player 1"
            self.txtFieldName.text = savedUserName.loadName()
            
            //self.PreviousName = "player 1"
            self.LabelPositions[0] = 1
            startButton.isEnabled = false
            //timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            
            self.btnClasicMode.backgroundColor = UIColor.green
        }else{
            
            startButton.isHidden = true
            
            
        }
        
        
        if(Host){
            
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
            DropDown.appearance().backgroundColor = UIColor.brown
            DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
            DropDown.appearance().cellHeight = self.timeSizeBtn.frame.height
            DropDown.appearance().frame.size.width = self.timeSizeBtn.frame.width
            DropDown.appearance().layer.cornerRadius = 5
            //Dro
            //DropDownCell.appearance().backgroundColor = UIColor.brown
            
            
            
            dropDownTime = DropDown()
            dropDownTime.anchorView = self.timeSizeBtn
            //dropDownTime.frame.size.width = self.timeSizeBtn.frame.width
            //dropDownTime.textFont.setT
            dropDownTime.dataSource = ["10","20","30","40","50","60","90","120","INF"]
            dropDownTime.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                if(item != "INF"){
                    self.myTimePerRoundDuration = Int(item)!
                }else{
                    self.myTimePerRoundDuration = -1
                }
                self.timeSizeBtn.setTitle(item, for: .normal)
                self.changeTime()
                //self.setSelectedTime()
            }
            //dropDownTime.width = self.timeSizeBtn.frame.width
            dropDownTime.direction = .bottom
            dropDownTime.cellHeight = self.timeSizeBtn.frame.height
            dropDownTime.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                // Setup your custom UI components
                cell.optionLabel.textAlignment = .center
            }
            
            
            dropDownTerrain = DropDown()
            dropDownTerrain.anchorView = self.terrainSizeBtn
            dropDownTerrain.frame.size.width = self.terrainSizeBtn.frame.width
            dropDownTerrain.dataSource = ["10 x 10","20 x 20","25 x 25","30 x 30","35 x 35","40 x 40","50 x 50"]
            dropDownTerrain.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                //var string:String = "\(item.startIndex())\(item.)"
                //var s:String = "\(item.startIndex)\(item.index(after: item.startIndex.index))"
                self.myTerrainSelectedSize = Int(self.getFirstTwoCharackterFrom(item: item))!
                self.terrainSizeBtn.setTitle(item, for: .normal)
                self.changeTerrainSize()
            }
            //dropDownTerrain.width = self.timeSizeBtn.frame.width
            dropDownTerrain.direction = .bottom
            dropDownTerrain.cellHeight = self.timeSizeBtn.frame.height
            dropDownTerrain.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                // Setup your custom UI components
                cell.optionLabel.textAlignment = .center
            }
            
        }
        
        FixVisualizationIfUserIsNotHost()
        self.addTapRecognizersToTextFields()
        //fixButtonAppearence()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        var str = txtFieldName.text!
        if (str != "Enter a name"){
            if(Host){
                hostFixHisName(name: str)}
            else{
                sendNewName()
            }
        }
    }
    func fixButtonAppearence(){
        
        //rotate player 2 buttons
        btnClasicMode.layer.cornerRadius = 10
        btnRandomMode.layer.cornerRadius = 10
        ExitBtn.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 10
        timeSizeBtn.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 10
        terrainSizeBtn.layer.cornerRadius = 10
        
        
        btnClasicMode.layer.cornerRadius = 10
        btnRandomMode.layer.cornerRadius = 10
        ExitBtn.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 10
        timeSizeBtn.layer.cornerRadius = 10
       terrainSizeBtn.layer.cornerRadius = 10
        
        btnClasicMode.layer.borderWidth = 1
        btnRandomMode.layer.borderWidth = 1
        ExitBtn.layer.borderWidth = 1
        startButton.layer.borderWidth = 1
        timeSizeBtn.layer.borderWidth = 1
        terrainSizeBtn.layer.borderWidth = 1
        
        btnClasicMode.titleLabel?.adjustsFontSizeToFitWidth = true
        btnRandomMode.titleLabel?.adjustsFontSizeToFitWidth = true
        ExitBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        timeSizeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        terrainSizeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        
        terrainSizeBtn.layer.shadowColor = UIColor.black.cgColor
        btnClasicMode.layer.shadowColor = UIColor.black.cgColor
        ExitBtn.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowColor = UIColor.black.cgColor
        timeSizeBtn.layer.shadowColor = UIColor.black.cgColor
        btnRandomMode.layer.shadowColor = UIColor.black.cgColor
        
        
        terrainSizeBtn.layer.shadowRadius = 2
        btnClasicMode.layer.shadowRadius = 2
        ExitBtn.layer.shadowRadius = 2
        startButton.layer.shadowRadius = 2
        timeSizeBtn.layer.shadowRadius = 2
        btnRandomMode.layer.shadowRadius = 2
        
        
    }
    
//    @objc func updateTimer(){
//        seconds = seconds + 1
//        if(seconds == 1){
//            sendMeToCheckIfYouAreHere()
//        }
//
//        if(seconds == 2){
//            if(playersHere.count < players.count){
//                for player in players{
//                    if (doesntExistsPlayer(playersHere: playersHere,player: player)){
//
//                        self.appDeligate.MulityPeerConnObj.advertizer = MCAdvertiserAssistant(serviceType: "vdiamant-game", discoveryInfo: nil, session: self.appDeligate.MulityPeerConnObj.session)
//                        self.appDeligate.MulityPeerConnObj.advertizer!.start()
//                        startButton.isEnabled = false
//                        clearPlayer(peerID: player.PeerID)
//                        sendUpDateNames()
//                    }
//                }
//            }
//        }
//        if(seconds == 6){
//            seconds = 0
//        }
//    }
    
//
//
//    func doesntExistsPlayer(playersHere: [Player],player: Player) -> Bool{
//        var found:Bool = false
//        for p in playersHere{
//            if(p.PeerID == player.PeerID){
//                found = true
//            }
//        }
//        return found
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getFirstTwoCharackterFrom(item: String) -> String{
        var metr = 0
        var newString = ""
        for char in item{
            newString.append(char)
            metr = metr + 1
            if(metr == 2){
                print("New String: \(newString)")
                return newString
            }
        }
        return "0"
    }
    
    
    func initializeAppDeligate(name: String){
        if(Host == true){
            appDeligate = UIApplication.shared.delegate as! AppDelegate
            appDeligate.MulityPeerConnObj = MultiPeerServiceManager()
            appDeligate.MulityPeerConnObj.setupPeerWithDisplayName(displayName: "GAME")
            self.players.append(Player(name: "player 1", color: UIColor.blue, PeerID: self.appDeligate.MulityPeerConnObj.peerID.description))
            self.players[0].position = 0
            //appDeligate.MulityPeerConnObj.browser.maximumNumberOfPeers = 4
            appDeligate.MulityPeerConnObj.setupSession()
            appDeligate.MulityPeerConnObj.advertiseSelf(advertise: true)
            
            
        }
        
    }
    
    
    func addTapRecognizersToTextFields(){
        
        txtFieldName.addTarget(self, action: #selector(setSelectedName), for: UIControlEvents.editingDidBegin)
        //txtBoxTerrainSize.addTarget(self, action: #selector(setSelectedTerrain), for: UIControlEvents.editingDidBegin)
       // txtBoxTimePerRound.addTarget(self, action: #selector(setSelectedTime), for: UIControlEvents.editingDidBegin)
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(selectedtextField != nil){
            callFunctionsToDismiss()
        }
    }
    
    
    @objc func setSelectedName(){
        self.selectedtextField = txtFieldName
    }
    
    
    
    func callFunctionsToDismiss(){
        switch selectedtextField {
        case txtFieldName:
            dismissKeyboardFromName()
            break
            
        default:
            print("Went to default")
        }
        selectedtextField = nil
        
    }
    
    
    
    @IBAction func terrainSizeBtnPressed(_ sender: UIButton) {
       dropDownTerrain.show()
    }
    
    
    @IBAction func timeDurationBtnPressed(_ sender: UIButton) {
//        var anchorPoint:CGPoint = CGPoint(x: self.timeSizeBtn.frame.origin.x, y: self.timeSizeBtn.frame.origin.y)
//        anchorPoint.y = anchorPoint.y + self.timeSizeBtn.frame.height
//        dropDownTime.topOffset = anchorPoint
        dropDownTime.show()
    }
    
    
    func dismissKeyboardFromName(){
        self.txtFieldName.resignFirstResponder()
        if let name:String = String(txtFieldName.text!){
            savedUserName.saveNewName(newName: txtFieldName.text!)
            if(Host){
                //appDeligate.MulityPeerConnObj.setupPeerWithDisplayName(displayName: name)
                //appDeligate.MulityPeerConnObj.session.name
                self.hostFixHisName(name: name)
                sendUpDateNames()
            }else{
                //PreviousName = name
                sendNewName()
            }
        }
    }
    func changeTerrainSize(){
        //self.txtBoxTerrainSize.resignFirstResponder()
        if let terrainSize:Int = self.myTerrainSelectedSize{
            self.lblTerrainSize.text = "\(terrainSize) x \(terrainSize)"
            self.gameTerrainSize = terrainSize
            sendTerrainUpdated(terrainSize: terrainSize)
        }
    }
    
    func hostFixHisName(name: String){
        for player in players{
            if(player.PeerID == self.appDeligate.MulityPeerConnObj.peerID.description){
                player.name = name
                namesLabels[player.position].text = name
            }
        }
    }
    
    
    func sendTerrainUpdated(terrainSize: Int){
        let messageDict = ["newTerrain":"\(terrainSize)"]
        sendAMessage(messageDict)
        
    }
    func changeTime(){
        //self.view.endEditing(true)
        //self.txtBoxTimePerRound.resignFirstResponder()
        if let timePerRound:Int = self.myTimePerRoundDuration{
            if(timePerRound == -1){
                lblTimePerRound.text = ("Infinite time")
            }else{
                lblTimePerRound.text = ("\(timePerRound) second")
            }
            self.gameTimePerRound = timePerRound
            self.sendTimeUpdated(timeUpdated : timePerRound)
        }
    }
    
    func sendTimeUpdated(timeUpdated : Int){
        let messageDict = ["newTime":"\(timeUpdated)"]
        sendAMessage(messageDict)
    }
    
    func FixVisualizationIfUserIsNotHost(){
        if Host == false {
            
            btnClasicMode.isEnabled = false
            btnRandomMode.isEnabled = false
            deckWar.isEnabled = false
            terrainSizeBtn.isHidden = true
            timeSizeBtn.isHidden = true
            
        }
    }
    
    @IBAction func classicBtnPressed(_ sender: UIButton) {
        self.btnClasicMode.backgroundColor = UIColor.green
        self.btnRandomMode.backgroundColor = UIColor.flatSand()
        self.deckWar.backgroundColor = UIColor.flatSand()
        self.gameMode = "Classic"
        sendGameMode(self.gameMode)
    }
    
    
    @IBAction func randomBtnPressed(_ sender: UIButton) {
        self.btnRandomMode.backgroundColor = UIColor.green
        self.btnClasicMode.backgroundColor = UIColor.flatSand()
        self.deckWar.backgroundColor = UIColor.flatSand()
        self.gameMode = "Random"
        sendGameMode(self.gameMode)
    }
    
    
    @IBAction func deckWarbtnPressed(_ sender: UIButton) {
        self.deckWar.backgroundColor = UIColor.green
        self.btnClasicMode.backgroundColor = UIColor.flatSand()
        self.btnRandomMode.backgroundColor = UIColor.flatSand()
        self.gameMode = "DeckWar"
        sendGameMode(self.gameMode)
    }
    
    
    
    @objc func peerChangedStateWithNotification(notification: NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        let state = userInfo.object(forKey: "state") as! String
        let intState = Int(state)
        if intState != MCSessionState.connecting.rawValue {
           //var newPlayer = Player(name: userInfo.object(forKey: "PeerID"), color: UIColor)
            //self.navigationItem.title = "Connected"
            //self.sendMyName()
            
            //Edw ginetai initialize to game kai apo tis 1 meries
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
            if(Host){
                if (message.object(forKey: "newPlayer") != nil){
                    var newPlayer:NSDictionary = message.object(forKey: "newPlayer") as! NSDictionary
                    var newPlayerName:String = newPlayer.object(forKey: "name") as! String
                    var newPlayerPeerID:String = newPlayer.object(forKey: "PeerID") as! String
                    addPlayer(playerName: newPlayerName,peerID: newPlayerPeerID)
                    checkIfStopAdvertizing()
                    sendUpDateNames()
                    sendTimeUpdated(timeUpdated: self.myTimePerRoundDuration)
                    sendTerrainUpdated(terrainSize: self.myTerrainSelectedSize)
                    sendGameMode(self.gameMode)
                    self.SendColors()
                    //sendIamVisible(true)
                    //self.enableStartFunction(true)
                }
            
            
            if (message.object(forKey: "LeftGame") != nil){
                
                
                    var leaverPeerID:String = message.object(forKey: "LeftGame") as! String
                    self.appDeligate.MulityPeerConnObj.advertizer = MCAdvertiserAssistant(serviceType: "vdiamant-game", discoveryInfo: nil, session: self.appDeligate.MulityPeerConnObj.session)
                    self.appDeligate.MulityPeerConnObj.advertizer!.start()
                    startButton.isEnabled = false
                    clearPlayer(peerID: leaverPeerID)
                    sendUpDateNames()
                
                
            }
                
                if(message.object(forKey: "HostIWantAnotherColor") != nil){
                    let someOneWantsAnotherColor:NSDictionary = message.object(forKey: "HostIWantAnotherColor") as! NSDictionary
                    let thatMansPeerID = someOneWantsAnotherColor.object(forKey: "PeerID") as! String
                    let thatMansColor = someOneWantsAnotherColor.object(forKey: "Color") as! String
                    
                    changeColorWithParameters(peerID: thatMansPeerID, Color: thatMansColor)
                }
                
                
                
                
                
            }
            
            if(message.object(forKey: "NewColors") != nil){
                
                let newColors:NSDictionary = message.object(forKey: "NewColors") as! NSDictionary
                self.topColor = newColors.object(forKey: "topColor") as! String
                self.botColor = newColors.object(forKey: "botColor") as! String
                self.leftColor = newColors.object(forKey: "leftColor") as! String
                self.rightColor = newColors.object(forKey: "rightColor") as! String
                self.updateColors()
                
                
            }
            
            
            if(message.object(forKey: "DisabledColors") != nil){
                self.colorsToDisable = message.object(forKey: "DisabledColors") as! [String]
            }
            
            
            if(message.object(forKey: "UpdateNames") != nil){
                if(Host == false){
                    let labelsBasedOnPlaces:NSDictionary = message.object(forKey: "UpdateNames") as! NSDictionary
                    
                    LabelTop.text = (labelsBasedOnPlaces.object(forKey: "1") as! String)
                    LabelBot.text = (labelsBasedOnPlaces.object(forKey: "2") as! String)
                    LabelLeft.text = (labelsBasedOnPlaces.object(forKey: "3") as! String)
                    LabelRight.text = (labelsBasedOnPlaces.object(forKey: "4") as! String)
                    
                    
                }
            }
            
            if(message.object(forKey: "newTime") != nil){
                if(Host == false){
                    let time:String = message.object(forKey: "newTime") as! String
                    if(time == "-1"){
                        lblTimePerRound.text = ("Infinite time")
                    }else{
                        lblTimePerRound.text = ("\(time) second")
                    }
                
                    
                }
            }
            
            if(message.object(forKey: "newTerrain") != nil){
                if(Host == false){
                    let terrain:String = message.object(forKey: "newTerrain") as! String
                    lblTerrainSize.text = ("\(terrain) x \(terrain)")
                    
                }
            }
            if(message.object(forKey: "HostLeft") != nil){
                let didHostLeft:String = message.object(forKey: "HostLeft") as! String
                    if didHostLeft == "True"{
                        //Edw mporei na mpeio
                        
                        let alert = UIAlertController(title: "Host Left", message: "Noob Host!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavController")                            
                            self.present(controller!, animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                
            }
            
            
            if(message.object(forKey: "HostIWantAnotherPosition") != nil) {
                if(Host){
                    let askForNewPosition:NSDictionary = message.object(forKey: "HostIWantAnotherPosition") as! NSDictionary
                    let positionHeWants:Int = askForNewPosition.object(forKey: "PositionIWant") as! Int
                    let askErID:String = askForNewPosition.object(forKey: "peerID") as! String
                    
                    var positionHeHas:Int!
                    var nameAsker:String!
                    
                    let positionHeAsks = positionHeWants
                    var peerIdReceiver:String!
                    
                    
                    
                    for player in players{
                        if(player.PeerID == askErID){
                            positionHeHas = player.position
                            nameAsker = player.name
                        }
                        if(player.position == positionHeWants){
                            peerIdReceiver = player.PeerID
                        }
                    }
                    if(positionHeWants == positionHeHas){
                        return
                    }
                    if(peerIdReceiver == nil){
                        //makeSwitch()
                        //changePositionWithEmpty(positionHeWants: positionHeWants,positionHeAsks: positionHeAsks,askErID: askErID)
                        
                        return
                    }
                    
                    
                    if(peerIdReceiver == self.appDeligate.MulityPeerConnObj.peerID.description){
                        let alert = UIAlertController(title: "Change Position", message: "\(nameAsker!) wants to change positions with you", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { action in
                            self.makePositionChange(PositionHeHas: positionHeHas,positionHeAsks: positionHeAsks,PeerIDAsker: askErID,peerIdReceiver: peerIdReceiver)
                            
                        }))
                        alert.addAction(UIAlertAction(title: "Decline", style: UIAlertActionStyle.default, handler: { action in
                            
                            var name:String!
                            for p in self.players {
                                if p.PeerID == peerIdReceiver{
                                    name = p.name
                                }
                            }
                            let messageDict = ["Rejection":["PeerIDAsker":askErID,"RejecterName":name]]
                            self.sendAMessage(messageDict)
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    
                    
                    let messageDict = ["SomeOneAskToChangePosition":["PositionHeHas": positionHeHas, "nameAsker": nameAsker, "positionHeAsks":positionHeAsks, "peerIdReceiver": peerIdReceiver,"PeerIDAsker":askErID]]
                    sendAMessage(messageDict)
                    
                    
                }
            }
            
            
            if(message.object(forKey: "SomeOneAskToChangePosition") != nil) {
                let someOneWantsYourPosition:NSDictionary = message.object(forKey: "SomeOneAskToChangePosition") as! NSDictionary
                
                let PositionHeHas:Int = someOneWantsYourPosition.object(forKey: "PositionHeHas") as! Int
                let nameAsker:String = someOneWantsYourPosition.object(forKey: "nameAsker") as! String
                let positionHeAsks:Int = someOneWantsYourPosition.object(forKey: "positionHeAsks") as! Int
                let peerIdReceiver:String = someOneWantsYourPosition.object(forKey: "peerIdReceiver") as! String
                let PeerIDAsker:String = someOneWantsYourPosition.object(forKey: "PeerIDAsker") as! String
                
                if(self.appDeligate.MulityPeerConnObj.peerID.description == peerIdReceiver){
                    let alert = UIAlertController(title: "Change Position", message: "\(nameAsker) wants to change positions with you", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { action in
                        if(self.Host == false){
                            let messageDict = ["AnswerToChangePosition":["PositionHeHas": PositionHeHas, "nameAsker": nameAsker, "positionHeAsks":positionHeAsks, "peerIdReceiver": peerIdReceiver,"PeerIDAsker":PeerIDAsker,"Answer":"Yes"]]
                            self.sendAMessage(messageDict)
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Decline", style: UIAlertActionStyle.default, handler: { action in
                        if(self.Host == false){
                            let messageDict = ["AnswerToChangePosition":["PositionHeHas": PositionHeHas, "nameAsker": nameAsker, "positionHeAsks":positionHeAsks, "peerIdReceiver": peerIdReceiver,"PeerIDAsker":PeerIDAsker,"Answer":"No"]]
                            self.sendAMessage(messageDict)
                        }
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                
            }
            
            if(message.object(forKey: "AnswerToChangePosition") != nil) {
                if(Host){
                    let someOneWantsYourPosition:NSDictionary = message.object(forKey: "AnswerToChangePosition") as! NSDictionary
                    
                    let PositionHeHas:Int = someOneWantsYourPosition.object(forKey: "PositionHeHas") as! Int
                    let nameAsker:String = someOneWantsYourPosition.object(forKey: "nameAsker") as! String
                    let positionHeAsks:Int = someOneWantsYourPosition.object(forKey: "positionHeAsks") as! Int
                    let peerIdReceiver:String = someOneWantsYourPosition.object(forKey: "peerIdReceiver") as! String
                    let PeerIDAsker:String = someOneWantsYourPosition.object(forKey: "PeerIDAsker") as! String
                    let Answer:String = someOneWantsYourPosition.object(forKey: "Answer") as! String
                    
                    
                    if(Answer == "Yes"){
                        makePositionChange(PositionHeHas: PositionHeHas,positionHeAsks: positionHeAsks,PeerIDAsker: PeerIDAsker,peerIdReceiver: peerIdReceiver)
                    }else{
                        
                        var name:String!
                        for p in players {
                            if p.PeerID == peerIdReceiver{
                                name = p.name
                            }
                        }
                        
                        
                        
                            if PeerIDAsker == self.appDeligate.MulityPeerConnObj.peerID.description{
                                if Answer != "Yes"{
                                    let alert = UIAlertController(title: "Decline", message: "\(name!) declined", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil ))
                                    self.present(alert, animated: true, completion: nil)
                                    return
                                }
                            }
                        
                        
                        
                        let messageDict = ["Rejection":["PeerIDAsker":PeerIDAsker,"RejecterName":name]]
                        self.sendAMessage(messageDict)
                    }
                
                
                }
                
                
                
            }
            
            
            if(message.object(forKey: "Rejection") != nil) {
                let message:NSDictionary = message.object(forKey: "Rejection") as! NSDictionary
                let myPeerID:String = message.object(forKey: "PeerIDAsker") as! String
                
                if(self.appDeligate.MulityPeerConnObj.peerID.description == myPeerID){
                    let rejecterName = message.object(forKey: "RejecterName")
                    let alert = UIAlertController(title: "Decline", message: "\(rejecterName!) declined", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil ))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
//            if(message.object(forKey: "AreYouHere") != nil){
//                if(Host == false){
//                    let messageDict = ["IAmHere":self.appDeligate.MulityPeerConnObj.peerID.description]
//                    sendAMessage(messageDict)
//                }
//            }
//
//
//            if(message.object(forKey: "IAmHere") != nil){
//                if(Host){
//                    var pID:String = message.object(forKey: "IAmHere") as! String
//                    for player in players {
//                        if player.PeerID == pID{
//                            playersHere.append(player)
//                        }
//                    }
//                }
//            }
            
            
            
            
            if(message.object(forKey: "NewName") != nil){
                if(Host){
                    let NewNameProperties:NSDictionary = message.object(forKey: "NewName") as! NSDictionary
                    
                    let newName = NewNameProperties.object(forKey: "nName") as! String
                    let newNamePeerID = NewNameProperties.object(forKey: "PeerID") as! String
                    for p in players{
                        if p.name == newName{
                            let message = ["ErrorWithRenamePleaseRename": newNamePeerID]
                            sendAMessage(message)
                            return
                        }
                    }
                    findAndChangeName(name: newName,peerID: newNamePeerID)
                    
                }
            }
            
            if(message.object(forKey: "ErrorWithRenamePleaseRename") != nil){
                let peerID:String = message.object(forKey: "ErrorWithRenamePleaseRename") as! String
                if(peerID == self.appDeligate.MulityPeerConnObj.peerID.description){
                    let alert = UIAlertController(title: "Name Error", message: "This name is being used from another player please change It :-) ", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                        self.txtFieldName.text = ""
                        self.txtFieldName.becomeFirstResponder()
                    }))
                }
            }
            
            
            
            if(message.object(forKey: "gameMode") != nil){
                let gMode:String = message.object(forKey: "gameMode") as! String
                if(gMode == "Classic"){
                    self.btnClasicMode.backgroundColor = UIColor.green
                    self.btnRandomMode.backgroundColor = UIColor.flatSand()
                    self.deckWar.backgroundColor = UIColor.flatSand()
                }else if(gMode == "Random"){
                    self.btnRandomMode.backgroundColor = UIColor.green
                    self.btnClasicMode.backgroundColor = UIColor.flatSand()
                    self.deckWar.backgroundColor = UIColor.flatSand()
                }else if(gMode == "DeckWar"){
                    self.deckWar.backgroundColor = UIColor.green
                    self.btnClasicMode.backgroundColor = UIColor.flatSand()
                    self.btnRandomMode.backgroundColor = UIColor.flatSand()
                }
            }
            
            if(message.object(forKey: "StartGame") != nil){
                let startGameInfo:NSDictionary = message.object(forKey: "StartGame") as! NSDictionary
                let pID:String = startGameInfo.object(forKey: "PeerID") as! String
                let position:Int = startGameInfo.object(forKey: "Position") as! Int
                let name:String = startGameInfo.object(forKey: "Name") as! String
                let positionThatIPlay = startGameInfo.object(forKey: "PositionThatWillPlay") as! Int
                let GameTime = startGameInfo.object(forKey: "GameTime") as! Int
                let GameTerrainSize = startGameInfo.object(forKey: "GameTerrainSize") as! Int
                let playerColorName = startGameInfo.object(forKey: "ColorName") as! String
                let GameMode = startGameInfo.object(forKey: "GameMode") as! String
                var selfPlayer:Player = Player(name: name, Position: position, PeerID: pID)
                selfPlayer.colorName = playerColorName
                selfPlayer.setColorBYGR()
                if(pID == self.appDeligate.MulityPeerConnObj.peerID.description){
                    let controller = storyboard?.instantiateViewController(withIdentifier: "gameAdaptiveViewController") as! gameAdaptiveViewController
                    controller.squaresPerSideOnImage = GameTerrainSize
                    controller.gameTimePerRound = GameTime
                    controller.myPosition = position
                    controller.mePlayer = selfPlayer
                    controller.positionThatIPlay = positionThatIPlay
                    controller.gameMode = GameMode
                    self.present(controller, animated: true, completion: nil)
                }
            }
            
            
        }catch{
            print(error)
        }
        
    }
    
    func sendSomeOneJoined(name : String){
        let messageDict = ["newPlayer":["name":name,"PeerID":self.appDeligate.MulityPeerConnObj.peerID.description]]
        sendAMessage(messageDict)
    }
    
    func sendGameMode(_ gameMode: String){
        let messageDict = ["gameMode":gameMode]
        sendAMessage(messageDict)
    }
    
    func addPlayer(playerName : String,peerID : String){
        //self.secondPlayerName.text = playerName
        if (players.count < 4) {
            var newPlayer = Player(name: getFreeName(), color: getFreeColor(), PeerID: peerID)
            self.players.append(newPlayer)
            var LabelName:UILabel = getFreeLabelPostion(newPlayer : newPlayer)
            LabelName.text = newPlayer.name
        }
        
        
    }
    
    func makePositionChange(PositionHeHas : Int,positionHeAsks : Int,PeerIDAsker : String,peerIdReceiver : String){
        var pAsker:Player!
        var posAsker:Int!
        var pAccepter:Player!
        var posAccepter:Int!
        changeColorBetweenTwoButtons(pos1: PositionHeHas, pos2: PositionHeHas)
        SendColors()
        for p in players {
            if(PeerIDAsker == p.PeerID){
                pAsker = p
                posAsker = p.position
                //p.position = positionHeAsks
                namesLabels[positionHeAsks].text = p.name
            }
            if(peerIdReceiver == p.PeerID){
                pAccepter = p
                posAccepter = p.position
                //p.position = PositionHeHas
                namesLabels[PositionHeHas].text = p.name
            }
            
            
            
        }
        pAsker.position = posAccepter
        pAccepter.position = posAsker
        sendUpDateNames()
        //self.updateColors()
        
        
        
        
    }
    
    
    func changeColorBetweenTwoButtons(pos1: Int,pos2: Int){
        var btnBefore = self.getButtonFromNumber(number: pos1)
        var btnAfter = self.getButtonFromNumber(number: pos2)
        var btnAfterColor = btnAfter.backgroundColor
        var btnBeforeColor = btnBefore.backgroundColor
        btnBefore.backgroundColor = btnAfterColor
        btnAfter.backgroundColor = btnBeforeColor
        changePositionedColorFromNumber(number1: pos1, number2: pos2)
    }
    
    
    
    func getFreeName() ->String{
        var metr = 0
        var listOf:[String] = []
        for lbl in namesLabels{
            listOf.append(lbl.text!)
        }
        for i in 1...4{
        if(listOf.contains("player \(i)") == false){
            return "player \(i)"
        }
        }
        return "Change Name"
    }
    
    func getFreeLabelPostion(newPlayer : Player) -> UILabel{
        
        for i in 0...LabelPositions.count - 1{
            if(LabelPositions[i] == 0){
                LabelPositions[i] = 1
                newPlayer.position = i
                return namesLabels[i] as! UILabel
            }
        }
        return namesLabels[0] as! UILabel
    }
    
    func getFreeColor() -> UIColor{
        var listColors:[UIColor] = [UIColor.blue,UIColor.red,UIColor.yellow,UIColor.green]
        var empyListOfColors:[UIColor] = []
        for player in players{
            empyListOfColors.append(player.color)
        }
            for color in listColors{
                if empyListOfColors.contains(color) != false{
                    return color
                }
            }
        print("Error")
        return UIColor.blue
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
    
    func checkIfStopAdvertizing(){
        if(self.appDeligate.MulityPeerConnObj.session.connectedPeers.count == 3){
            startButton.isEnabled = true
            if(self.appDeligate.MulityPeerConnObj.advertizer != nil){
                self.appDeligate.MulityPeerConnObj.advertizer!.stop()
                self.appDeligate.MulityPeerConnObj.advertizer = nil
            }
        }
    }
    
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        if(Host == false){
            sendIAmLeaving()
        }else{
            let messageDict = ["HostLeft":"True"]
            sendAMessage(messageDict)
        }
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNavController")
        
        self.present(controller!, animated: true, completion: nil)
        
    
    }
    
    
    func sendIAmLeaving(){
        let messageDict = ["LeftGame":self.appDeligate.MulityPeerConnObj.peerID.description]
        sendAMessage(messageDict)
    }
    
    
    func clearPlayer(peerID: String){
        var pos = 0
        for player in players{
            if player.PeerID == peerID{
                        namesLabels[player.position].text = "Waiting..."
                        LabelPositions[player.position] = 0
                        self.players.remove(at: pos)
                return
                }
            pos = pos + 1
            }
        
        
    }
    
    func findAndChangeName(name: String,peerID: String){
        for player in players{
            if player.PeerID == peerID{
                    namesLabels[player.position].text = name
                    sendUpDateNames()
                    player.name = name
//                    if(player.name == namesLabels[i].text){
//                        player.name = name
//                        namesLabels[i].text = name
//                        sendUpDateNames()
//                    }
                
            }
        }
    }
    
    func sendNewName(){
        let messageDict = ["NewName":["nName": self.txtFieldName.text! as String, "PeerID":self.appDeligate.MulityPeerConnObj.peerID.description]]
        sendAMessage(messageDict)
    }
    
    func sendUpDateNames(){
        let messageDict = ["UpdateNames":["1" : LabelTop.text, "2" : LabelBot.text, "3" : LabelLeft.text, "4" : LabelRight.text]]
        sendAMessage(messageDict)
    }
    
    
    
    
    func sendMeToCheckIfYouAreHere(){
        let messageDict = ["AreYouHere":"?"]
        sendAMessage(messageDict)
    }
    
    
    
    
    
//    func textFieldDidChange(textField: UITextField) {
//        print(textField.text!)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBOutlet weak var wantTopPlace: UIButton!
    @IBOutlet weak var wantRightPlace: UIButton!
    @IBOutlet weak var wantBotPlace: UIButton!
    @IBOutlet weak var wantLeftPlace: UIButton!
    
    
    @IBAction func funcWantTopPlace(_ sender: Any) {
       // askToChangePosition(PositionIWant: 0)
    }
    
    @IBAction func funcWantRightPlace(_ sender: Any) {
       // askToChangePosition(PositionIWant: 3)
    }
    
    
    @IBAction func funcWantBotPlace(_ sender: Any) {
        //askToChangePosition(PositionIWant: 1)
    }
    
    @IBAction func funcWantLeftPlace(_ sender: Any) {
        //askToChangePosition(PositionIWant: 2)
    }
    
    
//    func askToChangePosition(PositionIWant: Int){
//        if(Host){
//
//            if(LabelPositions[PositionIWant] == 0){
//                LabelPositions[PositionIWant] = 1
//                for p in players {
//                    if p.PeerID == self.appDeligate.MulityPeerConnObj.peerID.description{
//                        LabelPositions[p.position] = 0
//                        namesLabels[p.position].text = "Waiting..."
//                        p.position = PositionIWant
//                        namesLabels[PositionIWant].text = p.name
//                }
//
//                }
//                sendUpDateNames()
//            }else{
//                var positionHeHas:Int!
//                var nameAsker:String!
//                var peerIdReceiver:String!
//                for player in players{
//                    if(player.PeerID == self.appDeligate.MulityPeerConnObj.peerID.description){
//                        positionHeHas = player.position
//                        nameAsker = player.name
//                    }
//                    if(player.position == PositionIWant){
//                        peerIdReceiver = player.PeerID
//                    }
//                }
//
//
//                let messageDict = ["SomeOneAskToChangePosition":["PositionHeHas": positionHeHas, "nameAsker": nameAsker, "positionHeAsks":PositionIWant, "peerIdReceiver": peerIdReceiver,"PeerIDAsker":self.appDeligate.MulityPeerConnObj.peerID.description]]
//                sendAMessage(messageDict)
//
//
//            }
//
//
//
//        }else{
//            let messageDict = ["HostIWantAnotherPosition":["PositionIWant":PositionIWant,"peerID":self.appDeligate.MulityPeerConnObj.peerID.description]]
//            sendAMessage(messageDict)
//        }
//
//
//    }
    
    func getButtonFromNumber(number: Int) -> UIButton{
        switch number {
        case 0:
            return self.wantTopPlace
        case 1:
            return self.wantBotPlace
        case 2:
            return self.wantRightPlace
        case 3:
            return self.wantLeftPlace
        default:
            print("Default Error")
        }
        return self.wantTopPlace
    }
    
    
    func changePositionedColorFromNumber(number1: Int,number2 : Int ){
        switch number1 {
        case 1:
            self.topColor = getColorFromFourColors(num: number2)
            break
        case 2:
            self.topColor = getColorFromFourColors(num: number2)
            break
        case 3:
            self.topColor = getColorFromFourColors(num: number2)
            break
        case 4:
            self.topColor = getColorFromFourColors(num: number2)
            break
        default:
            print("Wrong")
        }
        
        switch number2 {
        case 1:
            self.topColor = getColorFromFourColors(num: number1)
            break
        case 2:
            self.topColor = getColorFromFourColors(num: number1)
            break
        case 3:
            self.topColor = getColorFromFourColors(num: number1)
            break
        case 4:
            self.topColor = getColorFromFourColors(num: number1)
            break
        default:
            print("Wrong")
        }
        
        
    }
    
    
    func getColorFromFourColors(num: Int) -> String{
        switch num {
        case 0:
            return topColor
        case 1:
            return botColor
        case 2:
            return rightColor
        case 3:
            return leftColor
        default:
            print("Wrong")
        }
        return topColor
    }
    
    
//    func changePositionWithEmpty(positionHeWants: Int,positionHeAsks: Int,askErID: String){
//        for p in players{
//            if p.PeerID == askErID{
//                namesLabels[p.position].text = "Waiting..."
//                LabelPositions[p.position] = 0
//
//                changeColorBetweenTwoButtons(pos1: positionHeWants, pos2: positionHeAsks)
//                SendColors()
//                p.position = positionHeWants
//
//                namesLabels[p.position].text = p.name
//                LabelPositions[p.position] = 1
//
//                //updateColors()
//            }
//
//        }
//        sendUpDateNames()
//    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
    
        
        //Edw prepei na valw ta xromata stous user!
        //shuffle()
        var metr = 0
        var HostPosition:Int!
        var arrayOfRandomPositions:[Int] = [1,2,3,4]
        var HostpID:String!
        var Hostposition:Int!
        var Hostyname:String!
        var HostColorName:String!
        for p in players{
            if(p.PeerID != self.appDeligate.MulityPeerConnObj.peerID.description){
                //p.position = metr
                p.setColorBYGR()
                var pRandomPos:Int = 0
                while pRandomPos == 0{
                    var randInt:Int = Int(arc4random_uniform(4))
                    pRandomPos = arrayOfRandomPositions[randInt]
                    arrayOfRandomPositions[randInt] = 0
                }
                let messageDict = ["StartGame":["PeerID": p.PeerID,"Position": p.position,"Name": p.name,"PositionThatWillPlay": pRandomPos,"GameTime": self.gameTimePerRound, "GameTerrainSize": self.gameTerrainSize,"GameMode": self.gameMode,"ColorName": p.colorName]]
                sendAMessage(messageDict)
            }else{
                //HostPosition = metr
                HostpID = p.PeerID
                Hostposition = p.position
                Hostyname = p.name
                HostColorName = p.colorName
            }
            metr = metr + 1
            
        }
        var controller = storyboard?.instantiateViewController(withIdentifier: "gameAdaptiveViewController") as! gameAdaptiveViewController
        
        //controller.myPosition = HostPosition
        
        var pRandomPos:Int = 0
        while pRandomPos == 0{
            var randInt:Int = Int(arc4random_uniform(4))
            pRandomPos = arrayOfRandomPositions[randInt]
            arrayOfRandomPositions[randInt] = 0
        }
        
        controller.positionThatIPlay = pRandomPos
        var p:Player = Player(name: Hostyname, Position: Hostposition, PeerID: HostpID)
        p.colorName = HostColorName
        p.setColorBYGR()
        controller.mePlayer = p
        controller.squaresPerSideOnImage = self.gameTerrainSize
        controller.gameTimePerRound = self.gameTimePerRound
        controller.gameMode = self.gameMode
        self.present(controller, animated: true, completion: nil)
        //var lostController = storyboard?.instantiateViewController(withIdentifier: "lost")
        //self.present(lostController!, animated: true, completion: nil)
        
        
        
        
        
    }
    
    func addCornerRadiusToLabels(){
        self.LabelBot.layer.cornerRadius = 10
        self.LabelTop.layer.cornerRadius = 10
        self.LabelRight.layer.cornerRadius = 10
        self.LabelLeft.layer.cornerRadius = 10
        
        self.lblTerrainSize.layer.cornerRadius = 10
        self.lblTimePerRound.layer.cornerRadius = 10
        
        
        self.btnClasicMode.layer.cornerRadius = 10
        self.btnRandomMode.layer.cornerRadius = 10
        self.ExitBtn.layer.cornerRadius = 10
        self.startButton.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func changeColorBtnPressed(_ sender: UIButton) {
        showColorPalette()
    }
    
    
//    func shuffle() {
//        if self.players.count < 2 { return }
//        for i in 0..<(self.players.count - 1) {
//            let j = Int(arc4random_uniform(UInt32(self.players.count - i))) + i
//            swap(&self.players[i], &self.players[j])
//        }
//    }
    
}


extension HostGameViewController{
    
    func showColorPalette(){
        let xibColorSelect:colorSelect = UINib(nibName: "colorSelect", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! colorSelect
        xibColorSelect.HostGVC = self
        xibColorSelect.center = self.view.center
        xibColorSelect.disableColorsUsed(ListOfColors : self.colorsToDisable)
        xibColorSelect.layer.shadowColor = UIColor.flatBlack().cgColor
        xibColorSelect.layer.shadowRadius = 5
        xibColorSelect.layer.masksToBounds = false
        xibColorSelect.layer.shadowOffset = CGSize(width: -15, height: 20)
        
        self.view.addSubview(xibColorSelect)
    }
    
    func sendIwantNewColor(color: String){
        if(Host){
                changeColorWithParameters(peerID: self.appDeligate.MulityPeerConnObj.peerID.description, Color: color)
            }else{
                let messageDict = ["HostIWantAnotherColor": ["PeerID":self.appDeligate.MulityPeerConnObj.peerID.description, "Color": color]]
                sendAMessage(messageDict)
        }
    }
    
    func SendColors(){
        let messageDict = ["NewColors": ["topColor":topColor, "botColor": botColor, "leftColor": leftColor, "rightColor": rightColor]]
        sendAMessage(messageDict)
    }
    
    func changeColorWithParameters(peerID: String, Color: String){
        for p in players{
            if p.PeerID == peerID{
                if(colorsToDisable.count > 0){
                for i in 0...colorsToDisable.count - 1{
                    if(colorsToDisable[i] == p.colorName){
                        colorsToDisable.remove(at: i)
                    }
                    }
                    
                }
                colorsToDisable.append(Color)
                self.sendDisabledColors()
                p.colorName = Color
                p.color = colorPalete.getColorFromString(color: Color)
                switch p.position{
                case 0:
                    wantTopPlace.backgroundColor = p.color
                    topColor = Color
                    break
                case 1:
                    wantBotPlace.backgroundColor = p.color
                    botColor = Color
                    break
                case 2:
                    wantRightPlace.backgroundColor = p.color
                    rightColor = Color
                    break
                case 3:
                    wantLeftPlace.backgroundColor = p.color
                    leftColor = Color
                    break
                default:
                    print("Error")
                }
            }
    }
    SendColors()
    
}
    
    
    func updateColors(){
        wantTopPlace.backgroundColor = colorPalete.getColorFromString(color: self.topColor)
        wantBotPlace.backgroundColor = colorPalete.getColorFromString(color: self.botColor)
        wantLeftPlace.backgroundColor = colorPalete.getColorFromString(color: self.rightColor)
        wantRightPlace.backgroundColor = colorPalete.getColorFromString(color: self.leftColor)
    }
    
    func sendDisabledColors(){
        let messageDict = ["DisabledColors":self.colorsToDisable]
        sendAMessage(messageDict)
    }
}



