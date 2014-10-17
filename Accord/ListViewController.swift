//
//  ListViewController.swift
//  Accord
//
//  Created by Leonardo Lee on 10/17/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var listsTableView: UITableView!
    var listAlertController : UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        self.listAlertController = setupListAlertController()
        
        let choreNib = UINib(nibName: "ChoreCell", bundle: nil)
        self.listsTableView.registerNib(choreNib, forCellReuseIdentifier: "CHORE_CELL")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupListAlertController() -> UIAlertController {
        let setupController = UIAlertController(title: "List Actions", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) {
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
    //MARK: UITableViewDataSource
    func prepareCell(identifier : String) {
        switch identifier {
        case "CHORE_CELL":
            println()
        default:
            println()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CHORE_CELL", forIndexPath: indexPath) as ChoreCell
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    

}
