//
//  InterfaceController.swift
//  DataTrackerWatch Extension
//
//  Created by Paul Pfeiffer on 19.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import DataTrackerWatchFramework

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let msg = message as? NSDictionary
        let ext = WKExtension.shared().delegate as! ExtensionDelegate
        ext.trafficStats = TrafficStats(fromDictionary: msg!)
        ext.reloadComplication()
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let msg = applicationContext as? NSDictionary
        let ext = WKExtension.shared().delegate as! ExtensionDelegate
        ext.trafficStats = TrafficStats(fromDictionary: msg!)
        ext.reloadComplication()
        
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        let msg = userInfo as? NSDictionary
        let ext = WKExtension.shared().delegate as! ExtensionDelegate
        ext.trafficStats = TrafficStats(fromDictionary: msg!)
        ext.reloadComplication()
    }
}



