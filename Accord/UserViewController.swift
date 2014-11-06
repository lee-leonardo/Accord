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

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("PREPPED") {
            let alert = UIAlertController(title: "Permissions will be Requested", message: "This app requires permissions to the ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "PREPPED")
        }
        
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        app.calendarController.checkEKAuthorizationStatus({
            (authorized, description) -> Void in
            if !authorized {
                let alert = UIAlertController(title: "App Requires Calendar Permission", message: description, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okay = UIAlertAction(title: "To Settings?", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    //
                    
                    
                })
                let cancel = UIAlertAction(title: "Ignore", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(okay)
                alert.addAction(cancel)
                
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                
                
            }
        })
    }
    
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

}
