//
//  MessageController.swift
//  Accord
//
//  Created by Leonardo Lee on 11/1/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import MessageUI

class MessageController {
    
    class var sharedInstance: MessageController {
        get {
            struct Static {
                static var instance : MessageController? = nil
            }
            
            if !(Static.instance != nil) {
                Static.instance = MessageController()
            }
            
            return Static.instance!
        }
    }
    
    init() {
        if MFMessageComposeViewController.canSendText() {
            if MFMessageComposeViewController.canSendAttachments() {
                
            }
        }
    }
    
    
    func composeMessage() {
        
    }
}
