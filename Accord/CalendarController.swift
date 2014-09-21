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
    
    //MARK: - Calendar
    func generateCalendar() {
        self.calendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: self.eventStore)
        NSUserDefaults.standardUserDefaults().setObject(self.calendar!.calendarIdentifier, forKey: "CalendarIdentifier")
        //This is also where I'll save it to Core Data.
        
        self.calendar!.title = "Accord Schedule"
        //self.calendar!.source =
        
    }
    
    func updateCalendars() {
        var error : NSError?
        
        //Batch is preferred... so I'll be tailoring to that in a moment.
        self.eventStore.saveCalendar(self.calendar, commit: true, error: &error)
        
        if error != nil {
            println("\(error?.localizedDescription)")
        }
        
    }
    
    //MARK: - Events
    func createEvent() {
        var event = EKEvent(eventStore: self.eventStore)
        //event.eventIdentifier //Gotta save this.
        
    }
    
    //I do not know if this is a feature I'd like yet, but it is nice to experiment with atm.
    //MARK: Reminders?
    func createRemindersForToday() {
        //This app fires everytime the app is opened to generate the task list, which then one can schedule for and confirm.
        
        var reminder = EKReminder(eventStore: self.eventStore)
        var startComponents = reminder.startDateComponents
        //startComponents.month
        
        var dueComponents = reminder.dueDateComponents
        
    }
}



//This is for the controller that houses the EKEventStoreController.
//        NSNotificationCenter.defaultCenter().addObserverForName(EKEventStoreChangedNotification, object: self, queue: <#NSOperationQueue?#>) {
//            (note) -> Void in
//            <#code#>
//        }
