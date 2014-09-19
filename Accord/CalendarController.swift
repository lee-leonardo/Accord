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
    var calendar : EKCalendar?
    
    init() {
        
        //Persists, create an EKEventStore once for a long time.
        //Stores hold calendars which hold events and reminders.

        self.eventStore = EKEventStore()
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent) {
            (granted, error) -> Void in
            if !granted {
                println("\(error.localizedDescription)")
            } else {
                if let calID = NSUserDefaults.standardUserDefaults().objectForKey("CalendarIdentifier") as? String {
                    self.calendar = self.eventStore.calendarWithIdentifier(calID) ?? self.eventStore.defaultCalendarForNewEvents
                } else {
                    self.generateCalendar()
                }
            }
        }
    }
    
    //TODO: Check for Updates to the Calendar, Add new reminders, notify user
    
    //MARK: Calendar
    func generateCalendar() {
        self.calendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: self.eventStore)
        NSUserDefaults.standardUserDefaults().setObject(self.calendar!.calendarIdentifier, forKey: "CalendarIdentifier")
        self.calendar!.title = "Accord Scheule"
        
    }
    
    func updateCalendars() {
        var error : NSError?
        
        //I don't know if synchronous or batch is preferred...
        self.eventStore.saveCalendar(self.calendar, commit: true, error: &error)
        
        if error != nil {
            println("\(error?.localizedDescription)")
        }
        
    }
    
    //MARK:
    func createRecurringEvent(frequency: EKRecurrenceFrequency, interval: Int, end: NSDate?) {
        if end == nil {
            
        }
    }
}



//This is for the controller that houses the EKEventStoreController.
//        NSNotificationCenter.defaultCenter().addObserverForName(EKEventStoreChangedNotification, object: self, queue: <#NSOperationQueue?#>) {
//            (note) -> Void in
//            <#code#>
//        }
