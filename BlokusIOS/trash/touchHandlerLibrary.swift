////
////  touchHandlerLibrary.swift
////  BlokusIOS
////
////  Created by Vasileios Diamantidis on 08/12/2017.
////  Copyright © 2017 vdiamant. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class touchHandlerLibrary{
//    
//    var smallBoxWidthHeight:CGFloat!
//    var selectedImage:UIImageView
//    
//    
//    init(){
//        
//    }
//    
////    func getSquares()->[String]{
////        var Strings:[String]=[]
////        var halfBox = smallBoxWidthHeight / 2
////        for ship in self.ships{
////            for i in 0...9{
////                for j in 0...9{
////                    if(isInside(loc: CGPoint(x: self.tenMultiTenImage.frame.origin.x + (CGFloat(i) * self.smallBoxWidthHeight) + halfBox, y: self.tenMultiTenImage.frame.origin.y + (CGFloat(j) * self.smallBoxWidthHeight) + halfBox), image: ship.shipImage)){
////                        var tmpStr:String = "\(j+1)\(i+1)"
////                        if(ship.sqaresThatCovers.contains(tmpStr) == false){
////                            ship.sqaresThatCovers.append(tmpStr)
////                        }
////                        Strings.append(tmpStr)
////                    }
////                }
////            }
////        }
////
////
////
////        return Strings
////    }
//    
//    var selectedImage:UIImage!
//    
//    func checkIfisOnAnotherImage(_ imageToPlace: UIImageView,_ boxSize: CGFloat) ->Bool{
//        if(selectedImage.horizontal){
//            if(checkIfisOnAnotherImageHorizontal(selectedImage.shipImage,boxSize)){
//                returnShip()
//                return true
//            }}else{
//            if(checkIfisOnAnotherImageVertical(selectedImage.shipImage,boxSize)){
//                returnShip()
//                return true
//            }}
//        return false
//        
//    }
//    
////    func rotateImage(selectedImage: UIImage){
////        print("It Worked")
////
////        UIView.animate(withDuration: 0.5) {
////            selectedImage.shipImage.transform = selectedImage.shipImage.transform.rotated(by: CGFloat(M_PI)/2)
////            selectedImage.horizontal = !selectedImage.horizontal
////            self.placeShip(selectedImage) //It doesn't work correct in rotation, some times it lets you put something ouside or above!
////        }
////        if(checkIfisOnAnotherImage(selectedImage.shipImage,self.smallBoxWidthHeight)){
////            //return rotation
////            for i in 1...3{
////                selectedImage.shipImage.transform = selectedImage.shipImage.transform.rotated(by: CGFloat(M_PI)/2)
////                selectedImage.horizontal = !selectedImage.horizontal
////                selectedImage.position=selectedImage.previousPosition
////                selectedImage.shipImage.center = selectedImage.previousPosition
////            }
////        }
////
////    }
//    
//    func checkIfisOnAnotherImageVertical(_ imageToPlace: UIImageView,_ boxSize: CGFloat) -> Bool{
//        for ship in ships{
//            if(imageToPlace != ship.shipImage){
//                var times:Int = Int(imageToPlace.frame.height / CGFloat(boxSize))
//                var debugOriginX = imageToPlace.frame.origin.x
//                var debugWidth = imageToPlace.frame.width
//                var debugHeight = imageToPlace.frame.height
//                for i in 1...((times*2)-1){
//                    var tmpMultiplier:CGFloat = CGFloat(i)
//                    if((isInside(loc: CGPoint(x: imageToPlace.frame.origin.x + boxSize/2, y: imageToPlace.frame.origin.y + CGFloat(tmpMultiplier * boxSize/2)), image: ship.shipImage))){
//                        return true
//                    }
//                }
//                
//                
//                
//                
//            }
//        }
//        return false
//    }
//    
//    
//    func checkIfisOnAnotherImageHorizontal(_ imageToPlace: UIImageView,_ boxSize: CGFloat) -> Bool{
//        for ship in ships{
//            if(imageToPlace != ship.shipImage){
//                var times:Int = Int(imageToPlace.frame.width / CGFloat(boxSize))
//                var debugOriginX = imageToPlace.frame.origin.x
//                var debugWidth = imageToPlace.frame.width
//                var debugHeight = imageToPlace.frame.height
//                for i in 1...((times*2)-1){
//                    var tmpMultiplier:CGFloat = CGFloat(i)
//                    if((isInside(loc: CGPoint(x: imageToPlace.frame.origin.x + CGFloat(tmpMultiplier * boxSize/2), y: imageToPlace.frame.origin.y + CGFloat(boxSize) / CGFloat(2)), image: ship.shipImage))){
//                        return true
//                    }
//                }
//                
//            }
//        }
//        return false
//    }
//    
//    func getDistanceBetweenCenter(_ location : CGPoint,_ imageCenter: CGPoint) -> CGPoint{
//        var distancex = location.x-imageCenter.x
//        var distancey = location.y-imageCenter.y
//        var result = CGPoint(x: distancex,y: distancey)
//        return result
//        
//    }
//    
//    func addDistance(beforeLocation : CGPoint, disttanceBetweenCenter: CGPoint) -> CGPoint{
//        return CGPoint(x: beforeLocation.x - disttanceBetweenCenter.x,y: beforeLocation.y - disttanceBetweenCenter.y)
//    }
//    
//    func placeShip(_ ship: Ship){
//        
//        var ShipStartX = ship.shipImage.frame.origin.x
//        var ShipStartY = ship.shipImage.frame.origin.y
//        
//        var startImagePositionX = tenMultiTenImage.frame.origin.x
//        var startImagePositionY = tenMultiTenImage.frame.origin.y
//        //        if(startImagePositionX > ShipStartX || startImagePositionY > ShipStartY){
//        //            returnShip()
//        //            return
//        //        }
//        
//        //Check the ends
//        
//        var shipEndX = ship.shipImage.frame.origin.x+ship.shipImage.frame.width
//        var shipEndY = ship.shipImage.frame.origin.y+ship.shipImage.frame.height
//        
//        
//        while(isInside(loc: CGPoint(x: shipEndX,y: shipEndY), image: tenMultiTenImage) == false){
//            if(shipEndX > tenMultiTenImage.frame.origin.x + tenMultiTenImage.frame.width){
//                ship.shipImage.frame.origin.x -= smallBoxWidthHeight/2
//            }
//            
//            if(shipEndY > tenMultiTenImage.frame.origin.y + tenMultiTenImage.frame.height){
//                ship.shipImage.frame.origin.y -= smallBoxWidthHeight/2
//            }
//            
//            
//            shipEndX = ship.shipImage.frame.origin.x+ship.shipImage.frame.width
//            shipEndY = ship.shipImage.frame.origin.y+ship.shipImage.frame.height
//            
//        }
//        
//        
//        //check The Starts
//        var shipStartX = ship.shipImage.frame.origin.x
//        var shipStartY = ship.shipImage.frame.origin.y
//        
//        
//        while(isInside(loc: CGPoint(x: shipStartX,y: shipStartY), image: tenMultiTenImage) == false){
//            if(shipStartX < tenMultiTenImage.frame.origin.x){
//                ship.shipImage.frame.origin.x += smallBoxWidthHeight/2
//            }
//            
//            if(shipStartY < tenMultiTenImage.frame.origin.y){
//                ship.shipImage.frame.origin.y += smallBoxWidthHeight/2
//            }
//            
//            
//            shipStartX = ship.shipImage.frame.origin.x
//            shipStartY = ship.shipImage.frame.origin.y
//            
//        }
//        
//        
//        
//        ShipStartX = ship.shipImage.frame.origin.x
//        ShipStartY = ship.shipImage.frame.origin.y
//        
//        startImagePositionX = tenMultiTenImage.frame.origin.x
//        startImagePositionY = tenMultiTenImage.frame.origin.y
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
//            ship.shipImage.frame.origin.x += smallBoxWidthHeight-remainX
//        }else{
//            ship.shipImage.frame.origin.x -= remainX
//        }
//        
//        
//        if(remainY > smallBoxWidthHeight / 2){
//            ship.shipImage.frame.origin.y += smallBoxWidthHeight-remainY
//        }else{
//            ship.shipImage.frame.origin.y -= remainY
//        }
//        
//        
//        checkIfisOnAnotherImage(ship.shipImage,smallBoxWidthHeight)
//        
//        //checkIfReadyToStart()
//        
//    }
//    
//    func returnShip(){
//        selectedImage.position=selectedImage.previousPosition
//        selectedImage.shipImage.center = selectedImage.previousPosition
//    }
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
////    func setselectedImage(firsttouch: UITouch){
////        for ship in ships {
////            if(self.isInside(touch: firsttouch, image: ship.shipImage)){
////                selectedImage = ship
////                return
////            }
////        }
////    }
////
////
//    
//}
//
//
