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
}
