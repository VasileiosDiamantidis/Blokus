//
//  tetrisComponent.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 11/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit

class tetrisComponent{
    
    var horizontalSquares:Int!
    var verticalSquares:Int!
    
    var myView:UIView!
    
    var squareSize:CGFloat!
    
    var myWidth:CGFloat!
    
    var mySquareSize:Int!
    
    var myList:[[Int]]!
    var color:UIColor!
    
    //Moving Variables
    var previousPosition:CGPoint!
    var position:CGPoint!
    var previousSize:CGSize!
    
    
    init(parrentSize:CGSize,list:[[Int]], Color: UIColor){
        self.horizontalSquares = list.count
        self.verticalSquares = list[0].count
        self.color = Color
        if(parrentSize.width > parrentSize.height){
            self.myWidth = parrentSize.height
        }else{
            self.myWidth = parrentSize.width
        }
        
        mySquareSize = 5
        
        let myX = (parrentSize.width / 2) - (self.myWidth / 2)
        let myY = (parrentSize.height / 2) - (self.myWidth / 2)
        
        myView = UIView(frame: CGRect(x: myX, y: myY, width: myWidth, height: myWidth))
        //myView.backgroundColor = UIColor.brown
        myView.isUserInteractionEnabled = false
        self.myList = list // ???
        print(self.myList)
        self.createSquares(list:list)
        
    }
    
    
    func createSquares(list:[[Int]]){
        let sqSize:CGFloat = self.myView.frame.width / CGFloat(self.mySquareSize)
        //var squareView = UIView(frame: CGRect(x: 0, y: 0, width: sqSize, height: sqSize))
        
        for i in 0...list.count - 1{
            for j in 0...list[i].count - 1{
                let x = CGFloat(j) * sqSize
                let y = CGFloat(i) * sqSize
                if(list[i][j] == 1){
                    let squareView = UIView(frame: CGRect(x: x, y: y, width: sqSize, height: sqSize))
                    squareView.backgroundColor = self.color
                    squareView.layer.borderColor = UIColor.black.cgColor
                    squareView.layer.borderWidth = 2
                    self.myView.addSubview(squareView)
                }
            }
        }
        
    }
    
    
}

//moving
extension tetrisComponent{
    //This function works only if it's a prive * prime placer
    func moveToLocation(location:CGPoint){
        self.myView.center = location
    }
    
    func returnToPreviousPostion(){
        UIView.animate(withDuration: 1) {
            self.myView.center = self.previousPosition
            self.myView.frame.size = self.previousSize
            self.redrawSquares()
        }
        
    }
    func redrawSquares(){
        self.createSquares(list: self.myList)
    }
    
    
    func rotateSelf(){
        //var newList:[[Int]] = [[myList[2][0],myList[1][0],myList[0][0]],[myList[2][1],myList[1][1],myList[0][1]],[myList[2][2],myList[1][2],myList[0][2]]]
        let L1:[Int] = [myList[4][0], myList[3][0], myList[2][0], myList[1][0], myList[0][0]]
        let L2:[Int] = [myList[4][1], myList[3][1], myList[2][1], myList[1][1], myList[0][1]]
        let L3:[Int] = [myList[4][2], myList[3][2], myList[2][2], myList[1][2], myList[0][2]]
        let L4:[Int] = [myList[4][3], myList[3][3], myList[2][3], myList[1][3], myList[0][3]]
        let L5:[Int] = [myList[4][4], myList[3][4], myList[2][4], myList[1][4], myList[0][4]]
        let newList:[[Int]] = [L1, L2, L3, L4, L5]
        self.myList = newList
        for view in self.myView.subviews{
            view.removeFromSuperview()
        }
        self.createSquares(list: newList)
    }
    
    func rotateUpDown(){
        //var newList:[[Int]] = [[myList[2][0],myList[1][0],myList[0][0]],[myList[2][1],myList[1][1],myList[0][1]],[myList[2][2],myList[1][2],myList[0][2]]]
        let L1:[Int] = myList[4]
        let L2:[Int] = myList[3]
        let L3:[Int] = myList[2]
        let L4:[Int] = myList[1]
        let L5:[Int] = myList[0]
        let newList:[[Int]] = [L1, L2, L3, L4, L5]
        self.myList = newList
        for view in self.myView.subviews{
            view.removeFromSuperview()
        }
        self.createSquares(list: newList)
    }
    
    
    
    
    func giveMeYourSquaresBasedOnPattern(rowLeftTheCenter: Int,colLeftTheCenter: Int) -> [[Int]]{
        var List:[[Int]] = []
        var tmpCol = 0
        var tmpRow = 0
        for rowMetr in 1...myList.count{
            for colMetr in 1...myList[rowMetr - 1].count{
                if(myList[rowMetr - 1][colMetr - 1] == 1){
                    if(rowMetr < (myList.count / 2)){
                        print("rowLeftTheCenter: \(rowLeftTheCenter)")
                        print("myList.count - rowMetr: \(myList.count - rowMetr)")
                        tmpRow = rowLeftTheCenter - (myList.count - rowMetr)
                    }else if (rowMetr + 1 >= (Int(myList.count / 2))){
                        print("rowLeftTheCenter: \(rowLeftTheCenter)")
                        print("myList.count - rowMetr: \(myList.count - rowMetr)")
                        tmpRow = rowLeftTheCenter + (myList.count - rowMetr)
                    }else{
                        tmpRow = rowLeftTheCenter
                    }
                    if(colMetr < (myList[rowMetr - 1].count / 2)){
                        print("colLeftTheCenter: \(rowLeftTheCenter)")
                        print("myList[rowMetr - 1].count - colMetr \(myList[rowMetr - 1].count - colMetr)")
                        tmpCol = colLeftTheCenter - (myList[rowMetr - 1].count - colMetr)
                    }else if (colMetr + 1 >= (Int(myList[rowMetr - 1].count / 2))){
                        print("colLeftTheCenter: \(rowLeftTheCenter)")
                        print("myList[rowMetr - 1].count - colMetr \(myList[rowMetr - 1].count - colMetr)")
                        tmpCol = colLeftTheCenter + (myList[rowMetr - 1].count - colMetr)
                    }else{
                        tmpCol = colLeftTheCenter
                    }
                    List.append([tmpRow - 1,tmpCol - 1])
                }
                
            }
        }
        print("H lista Pou epistrefei einai\(List)")
        return(List)
        
    }
    
    func giveMeYourSquaresBasedOnPatternFixed(rowLeftTheCenter: Int,colLeftTheCenter: Int) -> [[Int]]{
        var List:[[Int]] = []
        var tmpCol = 0
        var tmpRow = 0
        for rowMetr in 1...myList.count{
            for colMetr in 1...myList[rowMetr - 1].count{
                if(myList[rowMetr - 1][colMetr - 1] == 1){
                    if(rowMetr < 3){
                        tmpRow = rowLeftTheCenter - (3 - rowMetr)
                    }else if(rowMetr > 3){
                        tmpRow = rowLeftTheCenter + (rowMetr - 3)
                    }else{
                        tmpRow = rowLeftTheCenter
                    }
                    if(colMetr < 3){
                        tmpCol = colLeftTheCenter - (3 - colMetr)
                    }else if(colMetr > 3){
                        tmpCol = colLeftTheCenter + (colMetr - 3)
                    }else{
                        tmpCol = colLeftTheCenter
                    }
                    List.append([tmpRow,tmpCol])
                }
            }
        }
        print("H lista Pou epistrefei einai\(List)")
        return(List)
        
    }
    
    
}
