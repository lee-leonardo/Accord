//
//  NewChoreViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class NewChoreViewController: UITableViewController {

    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Chore"
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelNewChore:")
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "finishNewChore:")
        
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

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    */
    /*
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
//MARK: - Target-Action
    func cancelNewChore(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            //
        })
    }
    
    func finishNewChore(sender: UIBarButtonItem) {
        //
        self.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            //
        })
    }

}
