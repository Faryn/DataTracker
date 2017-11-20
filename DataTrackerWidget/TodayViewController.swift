//
//  TodayViewController.swift
//  DataTrackerWidget
//
//  Created by Paul Pfeiffer on 15.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import UIKit
import NotificationCenter
import DataTrackerFramework
import WatchConnectivity

class TodayViewController: TrafficDataViewController, NCWidgetProviding, WCSessionDelegate {
    
    // MARK: WCSessionDelegate
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activate()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        currentDataUseLabel.text = "--"
        maxDataUseLabel.text = "--"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.session = WCSession.default
        super.viewDidAppear(animated)
        fetchStats { error in
            if error == nil {
                if WCSession.isSupported() {
                    do {
                        try self.session?.updateApplicationContext((self.trafficStats?.trafficStats)! as! [String : Any])
                    } catch { }
                }
                self.currentDataUseLabel.text = self.trafficStats?.usedVolumeString
                self.maxDataUseLabel.text = self.trafficStats?.initialVolumeString
                self.timeRemainingLabel.text = self.trafficStats?.remainingTimeString?.appending(" remaining")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        fetchStats { error in
            if error == nil {
                self.currentDataUseLabel.text = self.trafficStats?.usedVolumeString
                self.maxDataUseLabel.text = self.trafficStats?.initialVolumeString
                self.timeRemainingLabel.text = self.trafficStats?.remainingTimeString?.appending(" remaining")

                completionHandler(NCUpdateResult.newData)
            } else { completionHandler(NCUpdateResult.failed) }
        }
        
    }
    @IBOutlet weak var currentDataUseLabel: UILabel!
    @IBOutlet weak var maxDataUseLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
}


