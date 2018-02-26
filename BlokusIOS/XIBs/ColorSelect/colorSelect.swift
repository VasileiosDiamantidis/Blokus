//
//  colorSelect.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 02/01/2018.
//  Copyright © 2018 vdiamant. All rights reserved.
//

import UIKit

class colorSelect: UIView {

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    var HostGVC:HostGameViewController!
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet weak var lblSelectColor: UILabel!
    
    var selectedColor = ""
    
    @IBOutlet weak var purpleBrn: UIButton!
    
    
    
    @IBOutlet var colorOultet: [UIButton]!
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func flatRedBtnPressed(_ sender: UIButton) {
        self.selectedColor = "FlatRed"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatOrangeBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatOrange"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatYellowBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatYellow"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatSandBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatSand"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatBlackBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatBlack"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatMagentaBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatMagenta"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatTealBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatTeal"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatSkyBlueBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatSkyBlue"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatGreenBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatGreen"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatMintBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatMint"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatGreyBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatGrey"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatForestGreenBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatForestGreen"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatPurpleBtnPleassed(_ sender: Any) {
        self.selectedColor = "FlatPurple"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    
    @IBAction func FlatBrownBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatBrown"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatPlumBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatPlum"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatWatermelonBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatWatermelon"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatLimeBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatLime"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatPinkBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatPink"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatMaroonBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatMaroon"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatCoffeBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatCoffee"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    
    @IBAction func FlatPowderBlue(_ sender: Any) {
        self.selectedColor = "FlatPowderBlue"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func StrawberryBtnPressed(_ sender: Any) {
        self.selectedColor = "Strawberry"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func LemonBtnPressed(_ sender: Any) {
        self.selectedColor = "Lemon"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func MarashinoBtnPressed(_ sender: Any) {
        self.selectedColor = "Marashino"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    @IBAction func FlatWhiteBtnPressed(_ sender: Any) {
        self.selectedColor = "FlatWhite"
        changeTopColor()
        HostGVC.sendIwantNewColor(color: self.selectedColor)
    }
    
    func changeTopColor(){
        self.lblSelectColor.backgroundColor = colorPalete.getColorFromString(color: self.selectedColor)
        self.topStackView.backgroundColor = colorPalete.getColorFromString(color: self.selectedColor)
    }
    
    
   
    
    @IBOutlet weak var MomstackView: UIStackView!
    
    @IBAction func colorPressed(_ sender: UIButton) {
        print(sender.backgroundColor!.description)
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    func disableColorsUsed(ListOfColors : [String]){
        for btn in self.colorOultet{
            btn.isEnabled = true
            btn.backgroundColor = btn.backgroundColor?.withAlphaComponent(1)
           // btn.backgroundColor
        }
        for c in ListOfColors{
            switch c{
            case "FlatRed":
                self.EditThisButton(btn: colorOultet[0])
                break
            case "FlatOrange":
                self.EditThisButton(btn: colorOultet[1])
                break
            case "FlatYellow":
                self.EditThisButton(btn: colorOultet[2])
                break
            case "FlatSand":
                self.EditThisButton(btn: colorOultet[3])
                break
            case "FlatBlack":
                self.EditThisButton(btn: colorOultet[4])
                break
            case "FlatMagenta":
                self.EditThisButton(btn: colorOultet[5])
                break
            case "FlatTeal":
                self.EditThisButton(btn: colorOultet[6])
                break
            case "FlatSkyBlue":
                self.EditThisButton(btn: colorOultet[7])
                break
            case "FlatGreen":
                self.EditThisButton(btn: colorOultet[8])
                break
            case "FlatMint":
                self.EditThisButton(btn: colorOultet[9])
                break
            case "FlatWhite":
                self.EditThisButton(btn: colorOultet[10])
                break
            case "FlatGrey":
                self.EditThisButton(btn: colorOultet[11])
                break
            case "FlatForestGreen":
                self.EditThisButton(btn: colorOultet[12])
                break
            case "FlatPurple":
                self.EditThisButton(btn: colorOultet[13])
                break
            case "FlatBrown":
                self.EditThisButton(btn: colorOultet[14])
                break
            case "FlatPlum":
                self.EditThisButton(btn: colorOultet[15])
                break
            case "FlatWatermelon":
                self.EditThisButton(btn: colorOultet[16])
                break
            case "FlatLime":
                self.EditThisButton(btn: colorOultet[17])
                break
            case "FlatPink":
                self.EditThisButton(btn: colorOultet[18])
                break
            case "FlatMaroon":
                self.EditThisButton(btn: colorOultet[19])
                break
            case "FlatCoffee":
                self.EditThisButton(btn: colorOultet[20])
                break
            case "FlatPowderBlue":
                self.EditThisButton(btn: colorOultet[21])
                break
            case "Strawberry":
                self.EditThisButton(btn: colorOultet[22])
                break
            case "Lemon":
                self.EditThisButton(btn: colorOultet[23])
                break
            case "Marashino":
                self.EditThisButton(btn: colorOultet[24])
                break
            default:
                print("Something Went wrong")
            }
        }
    }
    
    func EditThisButton(btn: UIButton){
        btn.isEnabled = false
        btn.backgroundColor = colorOultet[0].backgroundColor?.withAlphaComponent(0.3)
    }
}
