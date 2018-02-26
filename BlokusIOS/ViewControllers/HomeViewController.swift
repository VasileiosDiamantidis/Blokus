//
//  HomeViewController.swift
//  BlokusIOS
//
//  Created by Vasileios Diamantidis on 13/12/2017.
//  Copyright © 2017 vdiamant. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class HomeViewController: UIViewController, MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        appDeligate.MulityPeerConnObj.browser.dismiss(animated: true, completion: nil)
        print("viewDidAppear")
        print("Finish")
        let controller = storyboard?.instantiateViewController(withIdentifier: "HostGameViewController") as! HostGameViewController
        
        controller.Host = false
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        appDeligate.MulityPeerConnObj.browser.dismiss(animated: true, completion: nil)
        //appDeligate.MulityPeerConnObj = MultiPeerServiceManager()
        print("Cancel")
    }
    

    var appDeligate:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func loadXib(_ sender: Any) {
//        let xibQuote:colorSelect = UINib(nibName: "colorSelect", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! colorSelect
//        
//        //xibQuote.quote.attributedText = myString
//        
//        //xibQuote.frame.size.height = myString.heightWithConstrainedWidth(width: xibQuote.quote.frame.size.width - 47)
//        
//        
//        
//        self.view.addSubview(xibQuote)
//    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinBtnPressed(_ sender: UIButton) {
        initializeAppDeligate(name: UIDevice.current.name)
        NotificationCenter.default.addObserver(self, selector: #selector(peerChangedStateWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
        if appDeligate.MulityPeerConnObj.session != nil{
            //self.IsendMyName = false
            //sendIamVisible(false)
            appDeligate.MulityPeerConnObj.advertiseSelf(advertise: true)
            appDeligate.MulityPeerConnObj.setupBrowser()
            appDeligate.MulityPeerConnObj.browser.delegate = self
            self.appDeligate.MulityPeerConnObj.advertizer!.stop()
            self.appDeligate.MulityPeerConnObj.advertizer = nil
            //appDeligate.MulityPeerConnObj.browser.modalPresentationStyle = UIModalPresentationStyle
            self.present(appDeligate.MulityPeerConnObj.browser, animated:true, completion:nil)
            
        }
    }
    
    @IBAction func hostBtnPressed(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HostGameViewController") as! HostGameViewController
        
        controller.Host = true
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    
    func initializeAppDeligate(name: String){
        appDeligate = UIApplication.shared.delegate as! AppDelegate
        appDeligate.MulityPeerConnObj = MultiPeerServiceManager()
        appDeligate.MulityPeerConnObj.setupPeerWithDisplayName(displayName: name)
        appDeligate.MulityPeerConnObj.setupSession()
        
        
    }
    
    @objc func peerChangedStateWithNotification(notification: NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        let state = userInfo.object(forKey: "state") as! String
        let intState = Int(state)
        if intState != MCSessionState.connecting.rawValue {
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
            
            
            
            
            
            
        }catch{
            print(error)
        }
        
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
