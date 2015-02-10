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

class BaseCabCompany{
    var imageURL : String
    var companyDescription : String
    var companyName : String
    
    init(imageURL : String, companyDescription : String, companyName : String){
        self.imageURL = imageURL
        self.companyDescription = companyDescription
        self.companyName = companyName
    }
    
    func getCompanyDescription() -> String {
        return companyDescription;
    }
    
    func getCompanyName() -> String {
        return companyName
    }
    
    func getThumbnail(inout imageCache : [String : UIImage]) -> UIImage? {
        var image :UIImage? = imageCache[self.imageURL]
        
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: imageURL)!
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            let data = NSData(contentsOfURL: imgURL)
            if(data == nil){
                image = UIImage(named: "cab.jpeg")
            } else {
                image = UIImage(data: data!)
                imageCache[imageURL] = image!
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), {
            })
        }
        return image
    }
    
}
