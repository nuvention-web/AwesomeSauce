//
//  FBViewController.swift
//  allcabs
//
//  Created by Farley Center on 3/1/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import UIKit

class fBLogin : UIViewController, FBLoginViewDelegate {
    
    @IBOutlet weak var fbl : FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var fbl: FBLoginView = FBLoginView() //create login button on UIController
        //self.view.addSubview(fbl)
        // Do any additional setup after loading the view, typically from a nib.
        fbl.delegate = self
        fbl.readPermissions = ["public_profile", "email", "user_friends"]

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
    
    func GetFriendList()
    {
        // Get List Of Friends
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary
            println("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as NSArray
            
            for i in 0...data.count {
                let valueDict : NSDictionary = data[i] as NSDictionary
                let id = valueDict.objectForKey("id") as String
                println("the id value is \(id)")
            }
            
            var friends = resultdict.objectForKey("data") as NSArray
            println("Found \(friends.count) friends")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}