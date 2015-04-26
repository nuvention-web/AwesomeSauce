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
    
    var current_lat : Double! = 10.0
    var current_long : Double! = 10.0
    var ending_lat : Double! = 10.0
    var ending_long : Double! = 10.0
    var starting_lat : Double! = 10.0
    var starting_long : Double! = 10.0
    var start_time = NSDate();
    var end_time = NSDate();
    var userid : Double! = 10.0
    
    
//func StartNewRoute(current_lat : Double!,current_long : Double!,ending_lat : Double!,ending_long : Double!,starting_lat : Double!,starting_long : Double!,start_time: NSDate!)
func StartNewRoute()
{
    
            let myUrl = NSURL(string: "http://ec2-54-149-51-13.us-west-2.compute.amazonaws.com/AwesomeSauce/WebApp/index.php/trackNewRoute");
            let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        // Compose a query string
            let postString = "current_lat=\(current_lat)&current_long=\(current_long)&ending_lat=\(ending_lat)&ending_long=\(ending_long)&starting_lat=\(starting_lat)&starting_long=\(starting_long)&start_time=\(start_time)"
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
                        uniqueuserid = parseJSON["id"] as? String
                        println("id: \(uniqueuserid)")
                    }
                    
        }
        
        task.resume()
        println("Posted")
        
    }
    
func GetRouteByID(userid : String!)
    {
        println("InGet")
        let url = "http://ec2-54-149-51-13.us-west-2.compute.amazonaws.com/AwesomeSauce/WebApp/index.php/getRouteByID" //5f88eeea39ab660d924cc3c1dd5e8386
        let parameterString = "id=5f88eeea39ab660d924cc3c1dd5e8386"
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
            

    }
    task.resume()
    println("Getted")
        
    }

    
    func updateRouteByID()
    {
        
        let myUrl = NSURL(string: "http://ec2-54-149-51-13.us-west-2.compute.amazonaws.com/AwesomeSauce/WebApp/index.php/updateRouteByID");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        // Compose a query string
        let postString = "current_lat=\(current_lat)&current_long=\(current_long)&ending_lat=\(ending_lat)&ending_long=\(ending_long)&starting_lat=\(starting_lat)&starting_long=\(starting_long)&start_time=\(start_time)&id=5f88eeea39ab660d924cc3c1dd5e8386"
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
            }
        
    
        task.resume()
        println("updated")
        
}

}
    