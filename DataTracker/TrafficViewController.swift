//
//  ViewController.swift
//  DataTracker
//
//  Created by Paul Pfeiffer on 12.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import UIKit
import DataTrackerFramework

class TrafficViewController: TrafficDataViewController {
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchStats { error in
            if error == nil {
                self.label1.text = self.trafficStats!.usedVolumeString
                self.label2.text = self.trafficStats!.initialVolumeString
            }
            
        
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

