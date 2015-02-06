//
//  CabCompany.swift
//  AllCabs
//
//  Created by Farley Center on 2/5/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol CabCompany {
    
    
    func getCabWaitTimeInMinutes(start: CLLocationCoordinate2D) -> Int //minutes
    
    func getPriceInDollars(start: CLLocationCoordinate2D,
            end : CLLocationCoordinate2D)->Float
    
    func getThumbnail(inout imageCache : [String : UIImage]) -> UIImage
    func getCompanyDescription() -> String
    
    func orderCab(start: CLLocationCoordinate2D, creditCard : CreditCard?) -> Bool
    
}
