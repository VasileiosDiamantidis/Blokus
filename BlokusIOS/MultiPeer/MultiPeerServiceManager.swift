import Foundation
import MultipeerConnectivity

class MultiPeerServiceManager : NSObject, MCSessionDelegate {
    
    
    var browser:MCBrowserViewController!
    var peerID:MCPeerID!
    var session:MCSession!
    var advertizer:MCAdvertiserAssistant? = nil
    
    func setupPeerWithDisplayName(displayName:String){
        peerID = MCPeerID(displayName: ("\(displayName) \(arc4random_uniform(10000))"))
    }
    
    func setupSession(){
        session = MCSession(peer: peerID)
        session.delegate = self
    }
    
    func setupBrowser(){
        browser = MCBrowserViewController(serviceType: "vdiamant-game", session: session)
    }
    
    func advertiseSelf(advertise:Bool){
        if(advertise){
            advertizer = MCAdvertiserAssistant(serviceType: "vdiamant-game", discoveryInfo: nil, session: session)
            advertizer!.start()
        }else{
            advertizer!.stop()
            advertizer = nil
        }
    }
    
    
    
    
    //    lazy var session : MCSession = {
    //        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
    //        session.delegate = self
    //        return session
    //    }()
    
    
    //    func send(colorName : String) {
    //        NSLog("%@", "sendColor: \(colorName) to \(session.connectedPeers.count) peers")
    //
    //        if session.connectedPeers.count > 0 {
    //            do {
    //                try self.session.send(colorName.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
    //            }
    //            catch let error {
    //                NSLog("%@", "Error for sending: \(error)")
    //            }
    //        }
    //
    //    }
    
    
    
    
    
    
    
    func peerChangedStageWithNotigication(notification:NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        let state = userInfo.object(forKey: "state") as! Int
        if state != MCSessionState.connecting.rawValue{
            print("---------\n")
            print("Connected")
            print("---------\n")
        }
        
    }
    
    func handleReceiveDataWithNotification(notification: NSNotification){
        let userInfo = notification.userInfo! as Dictionary
        let receivedData:NSData = userInfo["data"] as! NSData
        do{
            let message = try JSONSerialization.jsonObject(with: receivedData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            let senderPeerId:MCPeerID = userInfo["PeerID"] as! MCPeerID
            let senderDisplayName = senderPeerId.displayName
            
            var color:String = (message.object(forKey: "Color") as? String)!
            
            
            //self.delegate?.colorChanged(colorString: color)
            
        }catch{
            print(error)
        }
        
    }
    
    
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let userInfo = ["peerID" : peerID, "state":state.rawValue.description] as [String : Any]
        DispatchQueue.main.async{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil, userInfo: userInfo)
        }
        //self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
        //session.connectedPeers.map{$0.displayName})
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data.count) bytes")
        let userInfo = ["data":data,"peerID":peerID] as [String : Any]
        DispatchQueue.main.async{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil, userInfo: userInfo)
        }
        //let str = String(data: data, encoding: .utf8)!
        //self.delegate?.colorChanged(manager: self, colorString: str)
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
}
