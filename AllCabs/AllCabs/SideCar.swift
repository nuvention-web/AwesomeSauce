//
//  SideCar.swift
//  AllCabs
//
//  Created by Farley Center on 2/5/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class SideCar : CabCompany{
    var imageURL : String
    var companyDescription : String
    
    init(imageURL : String, companyDescription : String){
        self.imageURL = imageURL
        self.companyDescription = companyDescription
    }
    
    func getCabWaitTimeInMinutes(start: CLLocationCoordinate2D) -> Int {
        return 15
    }
    
    func getPriceInDollars(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) -> Float {
        return 20.4
    }
    
    func getCompanyDescription() -> String {
        return companyDescription;
    }
    
    func orderCab(start: CLLocationCoordinate2D, creditCard: CreditCard?) -> Bool {
        return true
    }
    
    func getThumbnail(inout imageCache : [String : UIImage]) -> UIImage {
        var image :UIImage? = imageCache[self.imageURL]
        
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: imageURL)!
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    imageCache[self.imageURL] = image
                    dispatch_async(dispatch_get_main_queue(), {
                                })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), {
            })
        }
        
        return image!
        
    }
    
}
