//
//  MenuTableViewController.swift
//  allcabs
//
//  Created by Matthew Albrecht on 4/21/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import UIKit
@objc class MenuTableViewController : UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = true
    }
    func cancelCurrentRoute(){
        var swRevealViewController = self.parentViewController?.parentViewController as? SWRevealViewController
        var firstViewController = swRevealViewController?.frontViewController?.childViewControllers[0] as? FirstViewController
        firstViewController?.cancelCurrentRoute()
        var button = firstViewController?.navigationItem.leftBarButtonItem
        UIApplication.sharedApplication().sendAction(button!.action, to: button?.target, from: firstViewController, forEvent: nil)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0{
            //Cancel
            cancelCurrentRoute()
        }
    }
}