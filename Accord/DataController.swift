//
//  DataController.swift
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import CoreData

class DataController {
    var dataContext : NSManagedObjectContext
    var user : User
//    var fetchResults: NSFetchedResultsController?
    
    init() {
        self.dataContext = NSManagedObjectContext()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("username") != nil {
            var request = NSFetchRequest(entityName: "User")
            var error : NSError?
            var users = self.dataContext.executeFetchRequest(request, error: &error)
            
            if error != nil {
                
            } else {
            }
            
        } else {
            
            //NSUserDefaults.standardUserDefaults().setObject(<#value: AnyObject?#>, forKey: <#String#>)

        }
        
        //Delete this soon, this'll break the project. This is so the compiler stops yelling at me.
        self.user = User()
        
    }
    
    //MARK: Fetch
//    func fetchObjects(list: ChoreList) -> [Chores] {}
    
    func retrieveUserData() {
        
    }
    
}
