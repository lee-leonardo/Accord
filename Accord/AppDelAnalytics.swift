//
//  AppDelAnalytics.swift
//  Accord
//
//  Created by Leonardo Lee on 11/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit


//This doesn't work, will need to look into how to make this work. Is extensions on AppDel even possible?
extension AppDelegate {
    
    //MARK: - Google Tag Manager
    func gtmSetup() {
        //Google Tag Manager
        self.tagManager = TAGManager.instance()
        self.tagManager.logger.setLogLevel(kTAGLoggerLogLevelVerbose)
        self.tagManager.dispatchInterval = 1.0
    }
    
    //MARK: - Google Analytics
    func gaSetup() {
        self.ga = GAI.sharedInstance()
        self.ga.trackUncaughtExceptions = true
        self.ga.dispatchInterval = 20
        //self.ga.logger.logLevel //This no logLevel function.
        self.ga.defaultTracker = self.ga.trackerWithTrackingId("UA-56757896-1")
        //self.gaTracker = self.ga.defaultTracker
    }
    
}
