//
//  MenuTableViewController.swift
//  allcabs
//
//  Created by Matthew Albrecht on 4/21/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

//import Foundation
//import UIKit
@objc class MenuTableViewController : UITableViewController{
    var firstViewController : FirstViewController!
    var swRevealViewController : SWRevealViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = true
    }
    
    func getOtherViewControllers(){
        swRevealViewController = self.parentViewController?.parentViewController as? SWRevealViewController
        firstViewController = swRevealViewController?.frontViewController?.childViewControllers[0] as? FirstViewController
    }
    func cancelCurrentRoute(){
        if(swRevealViewController == nil || firstViewController == nil){
            getOtherViewControllers();
        }
        firstViewController?.cancelCurrentRoute()
        var button = firstViewController?.navigationItem.leftBarButtonItem
        UIApplication.sharedApplication().sendAction(button!.action, to: button?.target, from: firstViewController, forEvent: nil)
        
    }
    
    func shareCurrentRoute(){
        if(swRevealViewController == nil || firstViewController == nil){
            getOtherViewControllers()
        }
        firstViewController?.shareRoute()
        var button = firstViewController?.navigationItem.leftBarButtonItem
        UIApplication.sharedApplication().sendAction(button!.action, to: button?.target, from: firstViewController, forEvent: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0{
            //Cancel
            cancelCurrentRoute()
        } else if(indexPath.row == 1) {
            shareCurrentRoute()
        }
    }
}