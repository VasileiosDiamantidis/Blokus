//
//  colorPalete.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 02/01/2018.
//  Copyright © 2018 vdiamant. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class colorPalete {
    
    
    
    
    
    
    
    static func getColorFromString(color: String) ->UIColor{
        switch color {
        case "FlatRed":
            return UIColor.flatRed()
        case "FlatOrange":
            return UIColor.flatOrange()
        case "FlatYellow":
            return UIColor.flatYellow()
        case "FlatSand":
            return UIColor.flatSand()
        case "FlatNavyBlue":
            return UIColor.flatNavyBlue()
        case "FlatBlack":
            return UIColor.flatBlack()
        case "FlatMagenta":
            return UIColor.flatMagenta()
        case "FlatTeal":
            return UIColor.flatTeal()
        case "FlatSkyBlue":
            return UIColor.flatSkyBlue()
        case "FlatGreen":
            return UIColor.flatGreen()
        case "FlatMint":
            return UIColor.flatMint()
        case "FlatWhite":
            return UIColor.flatWhite()
        case "FlatGrey":
            return UIColor.flatGray()
        case "FlatForestGreen":
            return UIColor.flatForestGreen()
        case "FlatPurple":
            return UIColor.flatPurple()
        case "FlatBrown":
            return UIColor.flatBrown()
        case "FlatPlum":
            return UIColor.flatPlum()
        case "FlatWatermelon":
            return UIColor.flatWatermelon()
        case "FlatLime":
            return UIColor.flatLime()
        case "FlatPink":
            return UIColor.flatPink()
        case "FlatMaroon":
            return UIColor.flatMaroon()
        case "FlatCoffee":
            return UIColor.flatCoffee()
        case "FlatPowderBlue":
            return UIColor.flatPowderBlue()
        case "FlatBlue":
            return UIColor.flatBlue()
        case "Strawberry":
            var color:UIColor = UIColor(red: 255, green: 0, blue: 128, alpha: 1)
            return color
        case "Lemon":
            return UIColor(red: 255, green: 255, blue: 0, alpha: 1)
        case "Marashino":
            return UIColor(red: 195, green: 0, blue: 0, alpha: 1)
        case "Blue":
            return UIColor.blue
        case "Red":
            return UIColor.red
        case "Yellow":
            return UIColor.yellow
        case "Green":
            return UIColor.green
        
        default:
            return UIColor.flatWhite()
        }
    }
    
    
    
    static func getStringFromColor(color: UIColor) ->String{
        switch color {
        case UIColor.flatRed():
            return "FlatRed"
        case UIColor.flatOrange():
            return "FlatOrange"
        case UIColor.flatYellow():
            return "FlatYellow"
        case UIColor.flatSand():
            return "FlatSand"
        case UIColor.flatNavyBlue():
            return "FlatNavyBlue"
        case UIColor.flatBlack():
            return "FlatBlack"
        case UIColor.flatMagenta():
            return "FlatMagenta"
        case UIColor.flatTeal():
            return "FlatTeal"
        case UIColor.flatSkyBlue():
            return "FlatSkyBlue"
        case UIColor.flatGreen():
            return "FlatGreen"
        case UIColor.flatMint():
            return "FlatMint"
        case UIColor.flatWhite():
            return "FlatWhite"
        case UIColor.flatGray():
            return "FlatGrey"
        case UIColor.flatForestGreen():
            return "FlatForestGreen"
        case UIColor.flatPurple():
            return "FlatPurple"
        case UIColor.flatBrown():
            return "FlatBrown"
        case UIColor.flatPlum():
            return "FlatPlum"
        case UIColor.flatWatermelon():
            return "FlatWatermelon"
        case UIColor.flatLime():
            return "FlatLime"
        case UIColor.flatPink():
            return "FlatPink"
        case UIColor.flatMaroon():
            return "FlatMaroon"
        case UIColor.flatCoffee():
            return "FlatCoffee"
        case UIColor.flatPowderBlue():
            return "FlatPowderBlue"
        case UIColor.flatBlue():
            return "FlatBlue"
        case UIColor.blue:
            return "Blue"
        case UIColor.red:
            return "Red"
        case UIColor.yellow:
            return "Yellow"
        case UIColor.green:
            return "Green"
        default:
            return "FlatWhite"
        }
    }
    
    
    
    
    
}
