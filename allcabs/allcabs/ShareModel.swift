//
//  ShareModel.swift
//  allcabs
//
//  Created by Reshu Goel on 4/24/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation


class ShareModel
{
    static let myBaseURL : String = "http://ec2-54-149-51-13.us-west-2.compute.amazonaws.com/AwesomeSauce/WebApp/index.php"
    static var uniqueuserid : String!
    
    static func getParamStringFromViewController(firstViewController : FirstViewController) -> (String){
        let dictionary : [String:String] = getDictionaryFromViewController(firstViewController)
        return getParamStringFromDictionary(dictionary)
    }
    
    static func getDictionaryFromViewController(firstViewController : FirstViewController) -> ([String:String]){
        var dictionary = [String:String]()
        dictionary["current_lat"] = firstViewController.currentCoord?.latitude.description
        dictionary["current_long"] = firstViewController.currentCoord?.longitude.description
        dictionary["ending_address"] = firstViewController.endingAddress
        dictionary["starting_lat"] = firstViewController.startingCoord?.latitude.description
        dictionary["starting_long"] = firstViewController.startingCoord?.longitude.description
        dictionary["deviation_index"] = firstViewController.deviationIndex.description
        return dictionary
    }
    
    static func getParamStringFromDictionary(dictionary : [String:String]) -> (String){
        var paramString = ""
        for (key,value) in dictionary{
            if paramString != ""{
                paramString+="&"
            }
            paramString += "\(key)=\(value)"
        }
        
        return paramString
        
    }
//func StartNewRoute(current_lat : Double!,current_long : Double!,ending_lat : Double!,ending_long : Double!,starting_lat : Double!,starting_long : Double!,start_time: NSDate!)
    static func startNewRoute(sender: FirstViewController, completion: (()->())!)
    {
        let myUrl = NSURL(string: "\(myBaseURL)/trackNewRoute");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        // Compose a query string
        let postString = getParamStringFromViewController(sender)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                println("error=\(error)")
                return
            }
            
            // You can print out response object
            println("response = \(response)")
        
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
            if let parseJSON = myJSON {
                // Now we can access value of First Name by its key
                var firstNameValue = parseJSON["id"] as? String
                ShareModel.uniqueuserid = parseJSON["id"] as? String
                println("id: \(ShareModel.uniqueuserid)")
            }
            completion?()
        }
        
        task.resume()
        println("Posted")
        
    }
    
    static func getRouteByID(id : String, completion : ((json : NSDictionary!)->())!)
    {
        println("InGet")
        let url = "\(myBaseURL)/getRouteByID" //5f88eeea39ab660d924cc3c1dd5e8386
        let parameterString = "id=\(id)"
        let myUrl = NSURL(string: "\(url)?\(parameterString)")
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "GET";
        
        // Compose a query string
        //let postString = "id=\(uniqueuserid)"

        
        //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                println("error=\(error)")
                return
            }
            // You can print out response object
            println("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
//            
//            if let parseJSON = myJSON {
//                // Now we can access value of First Name by its key
//                var firstNameValue = parseJSON["id"] as? String
//                uniqueuserid = parseJSON["id"] as? String
//                println("id: \(uniqueuserid)")
//            }
            completion?(json: myJSON)

    }
    task.resume()
    println("Getted")
        
    }

    
    static func updateRouteByID(id : String, sender : FirstViewController, completion : (()->())!)
    {
        
        let myUrl = NSURL(string: "http://ec2-54-149-51-13.us-west-2.compute.amazonaws.com/AwesomeSauce/WebApp/index.php/updateRouteByID");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        // Compose a query string
        let postString = "id=\(id)&\(getParamStringFromViewController(sender))"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                println("error=\(error)")
                return
            }
            
            // You can print out response object
            println("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
//            if let parseJSON = myJSON {
//                // Now we can access value of First Name by its key
//                var firstNameValue = parseJSON["id"] as? String
//                uniqueuserid = parseJSON["id"] as? String
//                println("id: \(uniqueuserid)")
            completion?()
            }
        
    
        task.resume()
        println("updated")
        
}
    static func updateTrackee(trackee : Trackee, completion: (()->())!){
        
        getRouteByID(trackee.id){
            json in
            if let dict = json{
                trackee.trackeeData = dict
            }
            completion?()
        }
    }

}
    