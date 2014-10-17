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
        self.title = "User Settings"
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().postNotificationName("USER_SETTINGS_CHANGED", object: nil, userInfo: settingsDict)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:
    func cancelChanges(sender : UIBarButtonItem) {
        
    }
    func confirmChanges(sender : UIBarButtonItem) {
        
    }

}
