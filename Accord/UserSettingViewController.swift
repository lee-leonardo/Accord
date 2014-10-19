//
//  UserSettingViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController {
    
    var settingsDict = [String : Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigation()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UINavigationItems
    func prepareNavigation() {
        self.title = "User Settings"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelChanges:")
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "confirmChanges:")
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func cancelChanges(sender : UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func confirmChanges(sender : UIBarButtonItem) {
        //This is when you batch the changes and then submit them to the notification.
        
        self.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("USER_SETTINGS_CHANGED", object: nil, userInfo: self.settingsDict)
        })
    }

}
