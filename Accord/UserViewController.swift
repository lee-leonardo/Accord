//
//  UserViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var userAlertController : UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User"
        self.userAlertController = setupUserAlertController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUserAlertController() -> UIAlertController {
        let setupController = UIAlertController(title: "User Actions", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            
            let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("UserSettings") as UserSettingViewController
            settingsView.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            self.navigationController?.presentViewController(settingsView, animated: true, completion: nil)
            
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
