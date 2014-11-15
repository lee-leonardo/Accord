//
//  UserViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

/*
User VC primarily just displays the User's current information and such.
This is the default screen on launch.
*/

import UIKit

class UserViewController: UIViewController {
    
    var userAlertController : UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User"
        self.userAlertController = setupUserAlertController()
        
        
//        var loginView = FBLoginView()
//        loginView.center = self.view.center
//        self.view.addSubview(loginView)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        if !NSUserDefaults.standardUserDefaults().boolForKey("PREPPED") {
//            let alert = UIAlertController(title: "Permissions will be Requested", message: "This app requires permissions to the ", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "PREPPED")
//        }
        
//        NSNotificationCenter.defaultCenter().addObserverForName(EK_AUTH_FAIL, object: self, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
//            let alert = UIAlertController(title: "App Requires Permission", message: "This app requires calendar permissions to function.", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            let okay = UIAlertAction(title: "To Settings?", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
//                //
//                
//            })
//            let cancel = UIAlertAction(title: "Ignore", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            alert.addAction(okay)
//            alert.addAction(cancel)
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
        
        
        let app = UIApplication.sharedApplication().delegate as AppDelegate
//        app.calendarController.checkEventStoreAccessForCalendar()
        
        //TagConfig Man
        let container = app.container
        let idString = container?.stringForKey("app_id")!
        let versionString = container?.stringForKey("app_name")!
        println("id: \(idString)\nversion: \(versionString)")
        
        let osString = container?.stringForKey("os_version")!
        let hardwareString = container?.stringForKey("hardware")!
        let platformString = container?.stringForKey("platform")!
        println("os: \(osString)\nhardware: \(hardwareString)\nplatform: \(platformString)")
        
//        let hardware = UIDevice.hardwareSimpleDescription(UIDevice.currentDevice())
//        let os = UIDevice.currentDevice().systemVersion
        
        //Datalayer
        var datalayer = app.tagManager.dataLayer
        var tracker = app.ga.defaultTracker
        
        //TAG: appOpened
        datalayer.push(["event":"openScreen", "platform":"\(platformString)"])
        
        //TAG: latestHardware
        datalayer.push(["hardware":"\(hardwareString)", "os_version":"\(osString)", "platform":"\(platformString)"])
        
        tracker.set(kGAIScreenName, value: "User Screen")
        tracker.send(GAIDictionaryBuilder.createScreenView().build())
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: EK_AUTH_FAIL, object: nil)
    }
    
    
    //MARK: Setup
    func setupUserAlertController() -> UIAlertController {
        let setupController = UIAlertController(title: "User Actions", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            
            let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("UserSettings") as UserSettingViewController
            
            let settingsNav = UINavigationController(rootViewController: settingsView)
            settingsNav.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            
            self.navigationController?.presentViewController(settingsNav, animated: true, completion: nil)
            
        }
        setupController.addAction(settings)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            (action) -> Void in
        }
        setupController.addAction(cancel)
        
        return setupController
    }
    
    //MARK: - IBAction
    @IBAction func presentUserActions(sender: AnyObject) {
        if let popover = self.userAlertController?.popoverPresentationController {
            popover.barButtonItem = sender as UIBarButtonItem
        }
        self.presentViewController(self.userAlertController, animated: true) {
            () -> Void in
        }
    }
    
    
    @IBAction func fireGoogleTag(sender: AnyObject) {
        println("Fired off the Button")
        
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        let datalayer = app.tagManager.dataLayer
        let container = app.container
        let appID = app.container?.stringForKey("app_id")!
        let version = app.container?.stringForKey("os_version")!
        let device = app.container?.stringForKey("device_name")!
        let platform = app.container?.stringForKey("platform")!
        println("\n\n\nAppID: \(appID!)\nVersion: \(version)\nDevice: \(device)\nPlatform: \(platform)")
        
        //app.tagManager
        datalayer.push(["event":"fireGoogleTagButtonPressed", "app_id":"\(appID)", "os_version":"\(version)", "device_name":"\(device)", "platform":"\(platform)"])
    }
    

}
