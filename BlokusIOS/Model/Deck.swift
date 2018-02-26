//
//  Deck.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 27/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import Foundation
import UIKit







class Deck: NSObject, NSCoding{
    var name:String = ""
    var myListOfData: [[[Int]]] = []
    var numberOfPieces: Int64 = 0
    var numberOfSquares:Int64 = 0
    var date:String = ""
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(myListOfData, forKey: PropertyKey.myListOfData)
        aCoder.encode(numberOfPieces, forKey: PropertyKey.numberOfPieces)
        aCoder.encode(numberOfSquares, forKey: PropertyKey.numberOfSquares)
        aCoder.encode(date, forKey: PropertyKey.date)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        var myName:String!
        var myLOD:[[[Int]]]!
        var nop:Int64!
        var nos:Int64!
        var mydate:String!
        
        if let name1 = aDecoder.decodeObject(forKey: PropertyKey.name) as? String{
            myName = name1
        }
        if let myListOfData1 = aDecoder.decodeObject(forKey: PropertyKey.myListOfData) as? [[[Int]]]{
            myLOD = myListOfData1
        }
        if let numberOfPieces1:Int64 = aDecoder.decodeInt64(forKey: PropertyKey.numberOfPieces) as? Int64{
            nop = numberOfPieces1
        }
        if let numberOfSquares1:Int64 = aDecoder.decodeInt64(forKey: PropertyKey.numberOfSquares) as? Int64{
            nos = numberOfSquares1
        }
        if let date1 = aDecoder.decodeObject(forKey: PropertyKey.date) as? String{
            mydate = date1
        }
        
        self.init(n: myName, List: myLOD, numberOfP: nop, NumberofS: nos, d: mydate)
    }
    
    
    init(n:String, List: [[[Int]]], numberOfP: Int64, NumberofS:Int64,d: String){
        super.init()
        self.name = n
        self.myListOfData = List
        self.numberOfPieces = numberOfP
        self.numberOfSquares = NumberofS
        self.date = d
        //self.date = Date.no
    }
    
    
    
    //Mark Properties
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("decks")
    static let ArchiveURLSelectedDeck = DocumentsDirectory.appendingPathComponent("SelectedDeck")
    
    
    struct PropertyKey {
        static let name = "name"
        static let myListOfData = "myListOfData"
        static let numberOfPieces = "numberOfPieces"
        static let numberOfSquares = "numberOfSquares"
        static let date = "date"
    }
}
