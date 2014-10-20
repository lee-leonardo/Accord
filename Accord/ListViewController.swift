//
//  ListViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

/*
This view manages the Lists this user controls.
*/

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listsTableView: UITableView!
    var listAlertController : UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        self.listAlertController = setupListAlertController()
        
        self.listsTableView.delegate = self
        self.listsTableView.dataSource = self
        
        let choreNib = UINib(nibName: "ChoreCell", bundle: nil)
        self.listsTableView.registerNib(choreNib, forCellReuseIdentifier: "CHORE_CELL")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupListAlertController() -> UIAlertController {
        let setupController = UIAlertController(title: "List Actions", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let newList = UIAlertAction(title: "New List", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            println("New List")
        }
        setupController.addAction(newList)
        
        let settings = UIAlertAction(title: "General Settings", style: UIAlertActionStyle.Default) {
            (action) -> Void in
        }
        setupController.addAction(settings)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            (action) -> Void in
        }
        setupController.addAction(cancel)
        
        return setupController
    }
    
    //MARK: - IBAction
    @IBAction func presentListActions(sender: AnyObject) {
        if let popover = self.listAlertController?.popoverPresentationController {
            popover.barButtonItem = sender as UIBarButtonItem
        }
        self.presentViewController(self.listAlertController, animated: true) {
            () -> Void in
        }
    }
    
    
    //MARK: - UITableView
    //MARK: UITableIVewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let addChore = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Add") {
            (action, indexPath) -> Void in
            println("Add Chore Button")
        }
        addChore.backgroundColor = UIColor(hue: 205/360, saturation: 0.60, brightness: 0.70, alpha: 0.8)
        
        let settings = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Settings") {
            (action, indexPath) -> Void in
            println("List Settings Button")
        }
        settings.backgroundColor = UIColor(hue: 180/360, saturation: 0.40, brightness: 0.65, alpha: 0.8)
        
        return [addChore, settings]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Did Select Fired!")
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            () -> Void in
            self.listsTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    //MARK: UITableViewDataSource
    func prepareCell(cell : UITableViewCell, indexPath : NSIndexPath) {
        cell.textLabel?.text = "HI"
        cell.detailTextLabel?.text = "HI"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CHORE_CELL", forIndexPath: indexPath) as ChoreCell
        self.prepareCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    

}
