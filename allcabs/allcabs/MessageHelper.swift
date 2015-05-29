//
//  MessageHelper.swift
//  allcabs
//
//  Created by Matthew Albrecht on 5/28/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import MessageUI
class MessageHelper{
    
    static func sendMessage(sender: AnyObject, trackingID : String, FVC : FirstViewController) {
        var messageViewController = MFMessageComposeViewController()
        messageViewController.body = "I would like to share my location with you! The following link will allow you to track me until I reach my destination. Helm://?action=track&id=\(trackingID)"
        
        messageViewController.recipients = []
        messageViewController.messageComposeDelegate = FVC
        if(!MFMessageComposeViewController.canSendText()){
            let alertController = UIAlertController(title: "Unable To Text",message: "You are unable to text from your device.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            FVC.presentViewController(alertController, animated: true, completion: nil)
            println("messageViewController can't send text")
        } else {
            FVC.presentViewController(messageViewController, animated: false, completion: nil)
        }
    }
    
    static func getUserName(FVC : FirstViewController){
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Name", message: "Please input your name", preferredStyle: .Alert)
    
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
        textField.text = ""
        })
    
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            if let textField = alert.textFields![0] as? UITextField,
                   text = textField.text {
                    FVC.name = text
                    NSUserDefaults.standardUserDefaults().setObject(text, forKey: "name")
            }

        }))
    
        // 4. Present the alert.
        FVC.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func sendTrackeeDeviatedAlert(FVC : FirstViewController, trackee : Trackee){
        
        //Send alert
        var localNotification = UILocalNotification()
        localNotification.fireDate = nil //Fire immediately
        if let name = trackee.trackeeData["name"] as? NSString{
            localNotification.alertBody = "\(name) has significantly deviated from their expected path!"
        } else {
            localNotification.alertBody = "Someone you're tracking has significantly deviated from their expected path!"
        }
        localNotification.alertAction = "View Map" //Action when swiping alert
        localNotification.category = "devaitionAlertCategory"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        let alertController = UIAlertController(title: "Deviated From Path",message: localNotification.alertBody, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        FVC.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func sendTrackeeArrivedAlert(FVC : FirstViewController, trackee : Trackee){
        //Send alert
        var localNotification = UILocalNotification()
        localNotification.fireDate = nil //Fire immediately
        if let name = trackee.trackeeData["name"] as? NSString{
            localNotification.alertBody = "\(name) has arrived at their destination!"
        } else {
            localNotification.alertBody = "Someone you're tracking has arrived at their destination!"
        }
        localNotification.alertAction = "View Map" //Action when swiping alert
        localNotification.category = "devaitionAlertCategory"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        let alertController = UIAlertController(title: "Arrived at Destination",message: localNotification.alertBody, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        FVC.presentViewController(alertController, animated: true, completion: nil)

    }
    
    static func sendTrackeeCanceledAlert(FVC : FirstViewController, trackee : Trackee){
        //Send alert
        var localNotification = UILocalNotification()
        localNotification.fireDate = nil //Fire immediately
        if let name = trackee.trackeeData["name"] as? NSString{
            localNotification.alertBody = "\(name) has canceled their route!"
        } else {
            localNotification.alertBody = "Someone you're tracking has canceled their route!"
        }
        localNotification.alertAction = "View Map" //Action when swiping alert
        localNotification.category = "devaitionAlertCategory"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        let alertController = UIAlertController(title: "Canceled Route",message: localNotification.alertBody, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        FVC.presentViewController(alertController, animated: true, completion: nil)
        
    }
}
