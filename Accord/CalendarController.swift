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
    var eventCal : EKCalendar?
    var reminderCal : EKReminder?
    
    //If I want to do the singleton version.
    class func instance() {
    }
    
    init() {
        //Persists, create an EKEventStore once for a long time.
        //Stores hold calendars which hold events.
        self.eventStore = EKEventStore()
    }
    
    //MARK: - Calendar
    func generateCalendars() {
        self.eventCal = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: self.eventStore)
        NSUserDefaults.standardUserDefaults().setObject(self.eventCal!.calendarIdentifier, forKey: "EVENT_CAL_ID")
        //This is also where I'll save it to Core Data.
        
        
        self.eventCal!.title = "Accord Chores"
//        self.eventCal!.source
        
        //Apparently the way to build an iCloud calendar.
        for source in eventStore.sources() {
            if let getCalDAV = source as? EKSource {
                if getCalDAV.sourceType.value == EKSourceTypeCalDAV.value && getCalDAV.title == "iCloud" {
                    eventCal!.source = getCalDAV
                    break;
                }
            }
        }
    }
    
    func updateCalendars() {
        var error : NSError?
        
        //Batch is preferred... so I'll be tailoring to that in a moment.
        self.eventStore.saveCalendar(self.eventCal, commit: true, error: &error)
        
        if error != nil {
            println("\(error?.localizedDescription)")
        }
        
    }
    
    //MARK: - Events
    
    //Make this take in a EKCalendarItem, EKAlarm, EKRecurrenceRule
    //EKStructuredLocation
    func createChoreItems(item: EKCalendarItem, alarm: EKAlarm?, recurrenceRule rule:EKRecurrenceRule?) {
        var event = EKEvent(eventStore: self.eventStore)
        //event.eventIdentifier //Gotta save this.
        
        event.addAlarm(alarm)
        event.addRecurrenceRule(rule)
        
    }
    
    
    //MARK: Calendar Item
    func createCalendarItem(name title: String, startDate: NSDate?, deadline endDate: NSDate?) -> EKCalendarItem {
        
        var item = EKCalendarItem()
        item.title = title
        
//        item.location
//        item.creationDate
//        item.lastModifiedDate
//        item.url
        
//        item.calendarItemIdentifier
//        item.calendarItemExternalIdentifier
//        item.calendar
        
        return item
    }
    
    //MARK: Alarm Item
    func createAlarm() -> EKAlarm {
        var alarm = EKAlarm()
//        alarm.absoluteDate
//        alarm.relativeOffset
//        alarm.structuredLocation
//        alarm.proximity
        
        return alarm
        
    }
    
    func createRecurrenceRule() -> EKRecurrenceRule {
        var rule = EKRecurrenceRule()
        
        return rule
    }
    
    //MARK: ToDo (Reminders)
    func createToDo() {
        
        //Need to work on this one.
        self.reminderCal = EKReminder(eventStore: self.eventStore)
        
    }
    
    
    //MARK: - Setup
    func setupAccord() {
        //In here I'll do the first time setup for Accord. Meaning the setup of the two calendar items that will be used for the Calendar and the Reminder apps respectively.
    }
    
    
    //MARK: EKAuthorization
    func requestAccess() {
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent) {
            (granted, error) -> Void in
            if !granted {
                println("\(error?.localizedDescription)")
            } else {
                if let calID = NSUserDefaults.standardUserDefaults().objectForKey("CALENDAR_ID") as? String {
                    self.eventCal = self.eventStore.calendarWithIdentifier(calID) ?? self.eventStore.defaultCalendarForNewEvents
                } else {
                    self.generateCalendars()
                }
            }
        }
        //Post an authorization status notification?
    }
    
    func checkEKAuthorizationStatus(callback: (authorized: Bool, description: String?) -> Void) {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent)
        
        switch status {
        case EKAuthorizationStatus.Authorized:
            callback(authorized: true, description: nil)
            
        case EKAuthorizationStatus.Denied, EKAuthorizationStatus.Restricted:
            callback(authorized: false, description: "Authorization to the Calendar is denied or restricted.")
            
        case EKAuthorizationStatus.NotDetermined:
            self.requestAccess()
            
            
            //Recursive... since the authorization status check is async, I'll need to have a listener to really handle this.
            self.checkEKAuthorizationStatus({
                (authorized, description) -> Void in
                callback(authorized: authorized, description: description)
            })
        }
    }
    
    
//——————————————————————
    //I do not know if this is a feature I'd like yet, but it is nice to experiment with atm.
    //MARK: Reminders?
    func createRemindersForToday() {
        //This app fires everytime the app is opened to generate the task list, which then one can schedule for and confirm.
        
        var reminder = EKReminder(eventStore: self.eventStore)
        var startComponents = reminder.startDateComponents
        //startComponents.month
        
        var dueComponents = reminder.dueDateComponents
        
    }
//——————————————————————
}
