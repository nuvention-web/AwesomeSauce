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
        self.fbLogin.delegate = self
        self.fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        

    }
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        var friendNames : [String] = []
        var friendPics : [UIImage] = []
        
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary
            println("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as NSArray
            
            for i in 0...data.count {
                let valueDict : NSDictionary = data[i] as NSDictionary
                let userID = valueDict.objectForKey("id") as String
                friendNames.append(valueDict.objectForKey("name") as String)
                let id = valueDict.objectForKey("name") as String
                var url = NSURL (string : "http://graph.facebook.com/\(userID)/picture?type=large")
                let urlRequest = NSURLRequest(URL: url!)
                NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue())
                { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                    
                    // Display the image
                    friendPics.append(UIImage(data: data)!)
                    
                }
            }
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    
    
    }

    
}