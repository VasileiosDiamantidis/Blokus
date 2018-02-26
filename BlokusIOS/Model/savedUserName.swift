//
//  savedUserName.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 04/01/2018.
//  Copyright © 2018 vdiamant. All rights reserved.
//

import Foundation



class savedUserName: NSObject, NSCoding{
    
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: namePropertyKey.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let name1 = aDecoder.decodeObject(forKey: namePropertyKey.name) as? String{
            name = name1
        }
    }
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("savedName")
    
    var name:String = ""
    
    struct namePropertyKey {
        static let name = "savedname"
    }
    
    
    static func saveNewName(newName: String){
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(newName, toFile: savedUserName.ArchiveURL.path)
        if(isSuccesfulSave){
            print("Successfull Save")
        }else{
            print("Unsuccessfull Save")
        }
        print("Saving...")
    }
    
    static func loadName() -> String{
        var name = "Enter a name"
        if let newName = NSKeyedUnarchiver.unarchiveObject(withFile: savedUserName.ArchiveURL.path) as? String{
            name = newName
        }
        
        return name
    }
    
}
