//
//  NewListViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class NewListViewController: UITableViewController {
    
    @IBOutlet weak var listName: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New List"
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelNewList:")
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "finishNewList:")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = done

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:

    //MARK: - Delegation
    // MARK: UITableViewDatasource

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            println()
            return 2
        case 1:
            println()
            return 1
        default:
            println()
            return 0
        }
    }
    */
    
    //MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    
//MARK: - IBACTION
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        //let add = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Add") { (action, indexPath) -> Void in}
        //add.backgroundColor = UIColor(hue: 180/360, saturation: 0.65, brightness: 0.75, alpha: 1.0)
        
        let clear = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Clear") { (action, indexPath) -> Void in}
        clear.backgroundColor = UIColor.redColor()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                return [clear]
            default:
                return nil
            }
        case 1:
            return [clear]
            
        default:
            return nil
        }
    }

//MARK: - Target-Action
    func cancelNewList(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {
            () -> Void in
        })
    }
    
    func finishNewList(sender: UIBarButtonItem) {
        //Code
        self.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            //Done fired!
            println("Done fired!")

        })
    }
    
}
