//
//  ViewController.swift
//  DataTracker
//
//  Created by Paul Pfeiffer on 12.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import UIKit
import DataTrackerFramework
import WatchConnectivity
import UICircularProgressRing

class TrafficViewController: TrafficDataViewController, WCSessionDelegate {
    
    
    // MARK: WCSessionDelegate
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("%@", "activationDidCompleteWith activationState:\(activationState) error:\(error)")
    }
    
    var session: WCSession?
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.session = WCSession.default
        session?.delegate = self
        session?.activate()
        // Do any additional setup after loading the view, typically from a nib.
        //update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    
    func update() {
        fetchStats { error in
            if error == nil {
                self.label1.text = self.trafficStats!.usedVolumeString
                self.label2.text = self.trafficStats!.initialVolumeString
                self.progressRing.maxValue = CGFloat(self.trafficStats!.initialVolumeMB!)
                self.progressRing.setProgress(value: CGFloat(self.trafficStats!.usedVolumeMB!), animationDuration: 2)
                try? self.session?.updateApplicationContext(self.trafficStats!.trafficStats as! [String : Any])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

