//
//  MenuViewController.swift
//  allcabs
//
//  Created by Farley Center on 2/26/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

//import Foundation
//import UIKit
class MenuViewController :UIViewController{
    var searchBar : UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        var rectang = CGRectMake(0, 0, self.navigationController!.navigationBar.frame.width, self.navigationController!.navigationBar.frame.height);
        searchBar = UISearchBar(frame: rectang)
        searchBar.placeholder = "Destination"
        searchBar.keyboardType = UIKeyboardType.Default
                
        
        self.navigationItem.titleView = searchBar
                
        
        var menuButtonItem = self.navigationItem.leftBarButtonItem!
        
        if self.revealViewController() != nil {
            menuButtonItem.target = self.revealViewController()
            menuButtonItem.action = "revealToggle:"

            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } else {
            NSLog("No revealViewController")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CancelRoute"{
            if let firstViewController = segue.destinationViewController as? FirstViewController{
                firstViewController.cancelCurrentRoute()
            }
        }
    }
    
}