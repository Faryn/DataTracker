//
//  ComplicationController.swift
//  DataTrackerWatch Extension
//
//  Created by Paul Pfeiffer on 19.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import ClockKit
import WatchKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let myDelegate = WKExtension.shared().delegate as? ExtensionDelegate
        let template = CLKComplicationTemplateModularSmallRingText()
        template.textProvider = CLKSimpleTextProvider(text: String(describing: myDelegate!.trafficStats!.usedPercentage!))
        template.fillFraction = Float((myDelegate?.trafficStats?.usedPercentage)!)/100
        print(String(describing: myDelegate!.trafficStats!.usedPercentage!))
        print("\(template.fillFraction)")
        handler(CLKComplicationTimelineEntry(date: .init(timeIntervalSinceNow: 0), complicationTemplate: template))
    }
    
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "")
            template.fillFraction = 0.5
            handler(template)
        } else {
            handler(nil)
        }
    }
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        handler(Date(timeIntervalSinceNow: TimeInterval(30*60)))
    }
}
