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
    var friendNames : [String] = []
    var friendPics : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var fbl: FBLoginView = FBLoginView() //create login button on UIController
        //self.view.addSubview(fbl)
        // Do any additional setup after loading the view, typically from a nib.
        self.fbLogin.delegate = self
        self.fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        

    }
    
    func createFriendsInfo(data : NSArray)
    {
        println("Start Create")
        for i in 0..<data.count {
            let valueDict : NSDictionary = data[i] as! NSDictionary
            let userID = valueDict.objectForKey("id") as! String
            self.friendNames.append(valueDict.objectForKey("name") as! String)
            let id = valueDict.objectForKey("name") as! String
            var url = NSURL (string : "http://graph.facebook.com/\(userID)/picture?type=large")
            let urlRequest = NSURLRequest(URL: url!)
            let session = NSURLSession.sharedSession()
            
//            if let myURL = url{
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//                session.dataTaskWithURL(myURL) {data, response, error in
//                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//                    if let image = UIImage(data: data){
//                        self.friendPics.append(image)
//                        println("Print")
//                    }
//                
//                dispatch_async(dispatch_get_main_queue()) {
//                        //completion(places)
//                    }
//                    }.resume()
            
            //}
//                NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue())
//                { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
//                    
//                    // Display the image
//                    self.friendPics.append(UIImage(data: data)!)
            // }

            var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
            var error: NSErrorPointer = nil
//
                    if let ImageData : NSData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: response, error:nil)
                    {
                        var image = UIImage( data : ImageData)
                        self.friendPics.append(image!)
                        println("Image Appended")
                    }
            println("Create Friends Info \(self.friendNames.count) \(self.friendPics.count) ")
            }
    
        println("Create Friends Info \(self.friendNames.count) \(self.friendPics.count) ")
    }
    
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        
                println("Start Fetched")
                var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
                friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                    var resultdict = result as! NSDictionary
                    println("Result Dict: \(resultdict)")
                    var Data : NSArray = resultdict.objectForKey("data") as! NSArray
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.createFriendsInfo(Data)
                            //println("Perform \(self.friendNames.count) \(self.friendPics.count) ")
                            self.performSegueWithIdentifier("toFriendList", sender: self)
                            println("Perform \(self.friendNames.count) \(self.friendPics.count) ")
                        }
                }
        
        //self.performSegueWithIdentifier("toFriendList", sender: self)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        
//        println("Start Fetched")
//        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
//        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//            var resultdict = result as NSDictionary
//            //println("Result Dict: \(resultdict)")
//            var Data : NSArray = resultdict.objectForKey("data") as NSArray
//            self.createFriendsInfo(Data)
////
//        }
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
        self.friendNames = []
        self.friendPics = []
        println("Logout \(self.friendNames.count) \(self.friendPics.count) ")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if((segue.identifier == "toFriendList" ) && (self.friendNames.count > 0))
        {
            var fl : friendList = segue.destinationViewController as! friendList
            println("Prepare \(self.friendNames.count) \(self.friendPics.count) ")
            fl.name1 = self.friendNames
            fl.profilepics1 = self.friendPics
        }
        
    }
    
    
    


    
}