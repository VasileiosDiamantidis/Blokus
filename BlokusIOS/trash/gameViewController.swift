////
////  gameViewController.swift
////  BlokusIOS
////
////  Created by Vasileios Diamantidis on 08/12/2017.
////  Copyright © 2017 vdiamant. All rights reserved.
////
//
//import UIKit
//
//class gameViewController: UIViewController {
//
//    @IBOutlet weak var elementStackView: UIStackView!
//    @IBOutlet weak var terrainStack: UIStackView!
//    @IBOutlet weak var terrain: UIImageView!
//    
//    let numberOfSquaresPerDimension = 10
//    
//    
//    var smallBoxWidthHeight:CGFloat!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        smallBoxWidthHeight = self.terrain.frame.size.width / numberOfSquaresPerDimension
//        var tmpString = "kapaou"
//        //var tapRecognizer = UITapGestureRecognizer(target: self, action: imageTapped(sender:image00))
//        
//        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        //imageView.isUserInteractionEnabled = true
//        
////
////        for view in terrainStack.subviews{
////            for image in view.subviews{
////                image.isUserInteractionEnabled = true
////                image.addGestureRecognizer(tapGestureRecognizer)
////                //image.addGestureRecognizer(tapRecognizer)
////            }
////        }
//        
//        //var gest:recognizer
//        //firstfirstTetrist.isUserInteractionEnabled = true
//        //image00.isUserInteractionEnabled = true
//        //image00.addGestureRecognizer(tapGestureRecognizer)
//        //image01.isUserInteractionEnabled = true
//        //image01.addGestureRecognizer(tapGestureRecognizer)
//        //image00.addGestureRecognizer(imageTapped(sender: image00))
//        // Do any additional setup after loading the view.
//        
//        
//    }
//    
//    
//    
//    
//    
//    @IBAction func showResetMenu(_ gestureRecognizer: UILongPressGestureRecognizer) {
//        if gestureRecognizer.state == .began {
//            self.becomeFirstResponder()
//            //self.viewForReset = gestureRecognizer.view
//            
//            // Configure the menu item to display
//            //let menuItemTitle = NSLocalizedString("Reset", comment: "Reset menu item title")
//            //let action = #selector(ViewController.resetPiece(controller:))
//            //let resetMenuItem = UIMenuItem(title: menuItemTitle, action: action)
//            
//            // Configure the shared menu controller
//            //let menuController = UIMenuController.shared
//            //menuController.menuItems = [resetMenuItem]
//            
//            // Set the location of the menu in the view.
//           // let location = gestureRecognizer.location(in: gestureRecognizer.view)
//            //let menuLocation = CGRect(x: location.x, y: location.y, width: 0, height: 0)
//            //menuController.setTargetRect(menuLocation, in: gestureRecognizer.view!)
//            
//            // Show the menu.
//            //menuController.setMenuVisible(true, animated: true)
//        }
//        if gestureRecognizer.state == .ended{
//            print("ended")
//        }
//    }
//    
//    
////    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
////    {
////        var tappedImage = tapGestureRecognizer.view as! UIImageView
////        tappedImage.backgroundColor = UIColor.blue
////        // Your action
////    }
//    
//    
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    
//    
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        var touch = touches.first!
//        print("Began\(touch.location(in: self.view))")
//        
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        var touch = touches.first!
//        print("moved\(touch.location(in: self.view))")
//    }
//    
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        var touch = touches.first!
//        var location = touch.location(in: self.view)
//        print("-----------------Ended----------------")
//        print("Ended in view \(touch.location(in: self.view))")
//        if(isInside(loc: location, image: self.terrain)){
//            
//        }
//        
//        
//    }
//    
//    
//    
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//
//
//extension gameViewController {
//    
//    func isInside(touch: UITouch, image: UIImageView)->Bool{
//        var xPos = image.frame.origin.x
//        var yPos = image.frame.origin.y
//        var xPosWidth = image.frame.origin.x + image.frame.width
//        var yPosHeight = image.frame.origin.y + image.frame.height
//        var loc = touch.location(in: self.view)
//        
//        if(loc.x >=  xPos && loc.y >=  yPos && loc.x <= xPosWidth && loc.y <= yPosHeight){
//            return true
//        }else{
//            return false
//        }
//        
//    }
//    
//    
//    func isInside(loc: CGPoint, image: UIImageView)->Bool{
//        var xPos = image.frame.origin.x
//        var yPos = image.frame.origin.y
//        var xPosWidth = image.frame.origin.x + image.frame.width
//        var yPosHeight = image.frame.origin.y + image.frame.height
//        
//        if(loc.x >=  xPos && loc.y >=  yPos && loc.x <= xPosWidth && loc.y <= yPosHeight){
//            return true
//        }else{
//            return false
//        }
//        
//    }
//    
//    
//    
//    func placeShip(tetrisImage: TetrisImage){
//        
//        var ShipStartX = tetrisImage.Image.frame.origin.x
//        var ShipStartY = tetrisImage.Image.frame.origin.y
//        
//        var startImagePositionX = terrain.frame.origin.x
//        var startImagePositionY = terrain.frame.origin.y
//        //        if(startImagePositionX > ShipStartX || startImagePositionY > ShipStartY){
//        //            returnShip()
//        //            return
//        //        }
//        
//        //Check the ends
//        
//        var shipEndX = tetrisImage.Image.frame.origin.x+tetrisImage.Image.frame.width
//        var shipEndY = tetrisImage.Image.frame.origin.y+tetrisImage.Image.frame.height
//        
//        
//        while(isInside(loc: CGPoint(x: shipEndX,y: shipEndY), image: terrain) == false){
//            if(shipEndX > terrain.frame.origin.x + terrain.frame.width){
//                tetrisImage.Image.frame.origin.x -= smallBoxWidthHeight/2
//            }
//            
//            if(shipEndY > terrain.frame.origin.y + terrain.frame.height){
//                tetrisImage.Image.frame.origin.y -= smallBoxWidthHeight/2
//            }
//            
//            
//            shipEndX = tetrisImage.Image.frame.origin.x+tetrisImage.Image.frame.width
//            shipEndY = tetrisImage.Image.frame.origin.y+tetrisImage.Image.frame.height
//            
//        }
//        
//        
//        //check The Starts
//        var shipStartX = tetrisImage.Image.frame.origin.x
//        var shipStartY = tetrisImage.Image.frame.origin.y
//        
//        
//        while(isInside(loc: CGPoint(x: shipStartX,y: shipStartY), image: terrain) == false){
//            if(shipStartX < terrain.frame.origin.x){
//                tetrisImage.Image.frame.origin.x += smallBoxWidthHeight/2
//            }
//            
//            if(shipStartY < terrain.frame.origin.y){
//                tetrisImage.Image.frame.origin.y += smallBoxWidthHeight/2
//            }
//            
//            
//            shipStartX = tetrisImage.Image.frame.origin.x
//            shipStartY = tetrisImage.Image.frame.origin.y
//            
//        }
//        
//        
//        
//        ShipStartX = tetrisImage.Image.frame.origin.x
//        ShipStartY = tetrisImage.Image.frame.origin.y
//        
//        startImagePositionX = terrain.frame.origin.x
//        startImagePositionY = terrain.frame.origin.y
//        
//        
//        var distanceX = ShipStartX - startImagePositionX
//        var distanceY = ShipStartY - startImagePositionY
//        
//        var remainX = distanceX.truncatingRemainder(dividingBy: smallBoxWidthHeight)
//        var remainY = distanceY.truncatingRemainder(dividingBy: smallBoxWidthHeight)
//        
//        
//        
//        
//        
//        if(remainX > smallBoxWidthHeight / 2){
//            tetrisImage.Image.frame.origin.x += smallBoxWidthHeight-remainX
//        }else{
//            tetrisImage.Image.frame.origin.x -= remainX
//        }
//        
//        
//        if(remainY > smallBoxWidthHeight / 2){
//            tetrisImage.Image.frame.origin.y += smallBoxWidthHeight-remainY
//        }else{
//            tetrisImage.Image.frame.origin.y -= remainY
//        }
//        
//        
//        //checkIfisOnAnotherImage(tetrisImage.shipImage,smallBoxWidthHeight)
//        
//        //checkIfReadyToStart()
//        
//    }
//}

