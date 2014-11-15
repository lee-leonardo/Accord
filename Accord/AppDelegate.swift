//
//  AppDelegate.swift
//  Accord
//
//  Created by Leonardo Lee on 9/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import CoreData
import EventKit
import Fabric
import TwitterKit
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TAGContainerOpenerNotifier {

    var window: UIWindow?
    var calendarController = CalendarController()
    var calQueue = NSOperationQueue()
    
    var tagManager : TAGManager!
    var container : TAGContainer?
    
    var ga: GAI!
    var gaTracker : GAITracker!
    
    
    var tagQueue = NSOperationQueue()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Twitter(), Crashlytics()])
        
        NSNotificationCenter.defaultCenter().addObserverForName(EK_AUTH_ATTEMPT, object: self, queue: calQueue) {
            (note) -> Void in
        }
        
        //This is for the controller that houses the EKEventStoreController.
        NSNotificationCenter.defaultCenter().addObserverForName(EKEventStoreChangedNotification, object: self, queue: calQueue) {
            (note) -> Void in
        }
        
        //Google Tag Manager
        self.tagManager = TAGManager.instance()
        self.tagManager.logger.setLogLevel(kTAGLoggerLogLevelVerbose)
        
        self.ga = GAI.sharedInstance()
        self.ga.trackUncaughtExceptions = true
        self.ga.dispatchInterval = 20
        //self.ga.logger.logLevel //This no logLevel function.
        self.ga.defaultTracker = self.ga.trackerWithTrackingId("UA-56757896-1")
        //self.gaTracker = self.ga.defaultTracker
        
        /*
        * Opens a container.
        * @param containerId The ID of the container to load.
        * @param tagManager The TAGManager instance for getting the container.
        * @param openType The choice of how to open the container.
        * @param timeout The timeout period (default is 2.0 seconds).
        * @param notifier The notifier to inform on container load events.
        */
        
        TAGContainerOpener.openContainerWithId("GTM-T2SHZR", tagManager: self.tagManager, openType: kTAGOpenTypePreferFresh, timeout: nil, notifier: self)
        
        //Preview URL
        if let url = launchOptions?[UIApplicationLaunchOptionsURLKey] as? NSURL {
            self.tagManager.previewWithUrl(url)
        }
        
        //Future??
        //var future = TAGContainerOpener.openContainerWithId("GTM-T2SHZR", tagManager: self.tagManager, openType: kTAGOpenTypePreferNonDefault, timeout: nil) as TAGContainer
        //self.container = future.get()
        
        return true
    }
    
    //TAGContainerNotifier callback.
    func containerAvailable(container : TAGContainer) {
        dispatch_async(dispatch_get_main_queue(), {
            () -> Void in
            self.container = container
        })
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        //let facebook = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        //let twitter =
        
        let gtag = self.tagManager.previewWithUrl(url)
        
        return gtag
        //return facebook || twitter || gtag
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: EK_AUTH_ATTEMPT, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: EKEventStoreChangedNotification, object: nil)
        
        
        var calendarSave = application.beginBackgroundTaskWithExpirationHandler {
            () -> Void in
            
            var error : NSError?
            self.calendarController.eventStore.commit(&error)
            
            if error != nil {
                println("\(error?.localizedDescription)")
                //Send a message to crash/problem reporter stuff I'll implement later.
            }
        }
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            () -> Void in
            application.endBackgroundTask(calendarSave)
            calendarSave = UIBackgroundTaskInvalid
        })
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //FBAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: EK_AUTH_ATTEMPT, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: EKEventStoreChangedNotification, object: nil)
        
        
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "LL.Accord" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Accord", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Accord.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

