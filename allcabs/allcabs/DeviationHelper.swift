//
//  DeviationHelper.swift
//  allcabs
//
//  Created by Matthew Albrecht on 5/28/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

class DeviationHelper {
    static func sendDeviatedAlert(FVC : FirstViewController){
        
        //Send alert
        var localNotification = UILocalNotification()
        localNotification.fireDate = nil //Fire immediately
        localNotification.alertBody = "You have significantly deviated from your expected path!"
        localNotification.alertAction = "View Map" //Action when swiping alert
        localNotification.category = "devaitionAlertCategory"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        let alertController = UIAlertController(title: "Deviated From Path",message: "You have significantly deviated from your expected path!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        FVC.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func calculateDeviationIndex(FVC : FirstViewController)->() {
        var path = FVC.path
        if path == nil{
            return
        }
        let length = path.lengthOfKind(kGMSLengthGeodesic) * 0.000621371; // in miles
        var minDistance : Double = 9999999;
        var distance = 0.01
        if path.count() > 1{
            
            while (!GMSGeometryIsLocationOnPathTolerance(FVC.currentCoord, path, true, distance/0.000621371)){
                distance *= 1.5
            }
            distance /= 1.5
        }
        FVC.deviationIndex = (length > 1) ? distance / pow(length,0.65) : distance / length
        if (FVC.deviationIndex > 1 && !FVC.deviatedFromPath){
            FVC.deviatedFromPath = true
            DeviationHelper.sendDeviatedAlert(FVC)
        }
    }

    static func reachedDestination(FVC : FirstViewController)->(Bool){
        if let ending_coord = FVC.path?.coordinateAtIndex(FVC.path.count()-1){
            if GMSGeometryDistance(ending_coord, FVC.currentCoord) < 50{
                return true
            }
        }
        return false
    }
}