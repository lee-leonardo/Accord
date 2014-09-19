//
//  CalendarController.swift
//  Accord
//
//  Created by Leonardo Lee on 9/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import EventKit

class CalendarController {
    
    var eventStore : EKEventStore
    
    init() {
        
        //Persists, create an EKEventStore once for a long time.
        //Stores hold calendars which hold events and reminders.
        
        self.eventStore = EKEventStore()
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent) {
            (granted, error) -> Void in
            if granted {
                
            } else {
                println("\(error.localizedDescription)")
            }
        }
        
//This is for the controller that houses the EKEventStoreController.
//        NSNotificationCenter.defaultCenter().addObserverForName(EKEventStoreChangedNotification, object: self, queue: <#NSOperationQueue?#>) {
//            (note) -> Void in
//            <#code#>
//        }
    }
    
    //TODO: Check for Updates to the Calendar, Add new reminders, notify user
    
    
    
    
    //MARK:
    func updateCalendars() {
        
    }
    
    //MARK:
    //This doesn't create... got to fix this up.
    func createChoreList() {
        let store = EKEventStore()
        store.requestAccessToEntityType(EKEntityTypeReminder, completion: {
            (bool: Bool, error: NSError!) -> Void in
            if error != nil {
                println("\(error.localizedDescription)")
            } else {
                
            }
        })
        let calendar = EKCalendar(forEntityType: EKEntityTypeReminder, eventStore: self.eventStore)
    }
    
    //MARK:
    func createRecurringEvent(frequency: EKRecurrenceFrequency, interval: Int, end: NSDate?) {
        if end == nil {
            
        }
    }
    
    
    
}
