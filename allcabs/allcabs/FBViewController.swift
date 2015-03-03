//
//  FBViewController.swift
//  allcabs
//
//  Created by Farley Center on 3/1/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import UIKit

class FBViewController : UIViewController, FBLoginViewDelegate {
    
    
    @IBOutlet var fbLogin: FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var fbl: FBLoginView = FBLoginView() //create login button on UIController
        //self.view.addSubview(fbl)
        // Do any additional setup after loading the view, typically from a nib.
        println("1")
        self.fbLogin.delegate = self
        self.fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        

    }
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("1 skdjfs lkdvj")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}