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
    
    func saveCalendars() {
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
        //rule.recurrenceEnd
        
        return rule
    }
    
//MARK: - Setup
    func setupAccord() {
        //In here I'll do the first time setup for Accord. Meaning the setup of the two calendar items that will be used for the Calendar and the Reminder apps respectively.
    }
    
//MARK: - Calendar
    func createCalendar() {
        self.eventCal = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: self.eventStore)
        NSUserDefaults.standardUserDefaults().setObject(self.eventCal!.calendarIdentifier, forKey: EK_EVENT_ID)
        //This is also where I'll save it to Core Data.
        
        
        //TODO: Use this
        NSNotificationCenter.defaultCenter().postNotificationName(CD_NEW_CAL, object: self, userInfo: ["ID":self.eventCal!.calendarIdentifier])
        
        self.eventCal!.title = "Accord Chores"
        self.eventCal!.source = eventStore.defaultCalendarForNewEvents.source
    }
    
    //Update
    func updateCalendars() {
        
    }
    
//MARK: - EKAuthorization
    func checkEventStoreAccessForCalendar() {
        var status = EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent)
        switch status {
        case .NotDetermined:
            self.requestCalendarAccess()
        case .Authorized:
            self.accessGrantedForCalendar()
        case .Restricted, .Denied:
            //Present alertView
            NSNotificationCenter.defaultCenter().postNotificationName(EK_AUTH_FAIL, object: nil)
        }
    }
    
    func requestCalendarAccess() {
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            (granted, error) -> Void in
            if granted {
                self.accessGrantedForCalendar()
            } else {
                println("\(error.localizedDescription)")
                NSNotificationCenter.defaultCenter().postNotificationName(EK_AUTH_FAIL, object: self)
            }
        })
    }
    
    func accessGrantedForCalendar() {
        if let calID = NSUserDefaults.standardUserDefaults().stringForKey(EK_EVENT_ID)? {
            self.eventCal = self.eventStore.calendarWithIdentifier(calID) ?? self.eventStore.defaultCalendarForNewEvents
        } else {
            self.createCalendar()
        }
    }
    
//MARK: -
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
    
//TODO: (Reminders) --Do not focus on atm.
    func createToDo() {
        
        //Need to work on this one.
        self.reminderCal = EKReminder(eventStore: self.eventStore)
        
    }
}
