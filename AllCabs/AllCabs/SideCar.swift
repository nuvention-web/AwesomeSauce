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

class SideCar : BaseCabCompany, CabCompany{
    
    override init(imageURL : String, companyDescription : String){
        super.init(imageURL: imageURL,companyDescription: companyDescription)
    }
    
    func getCabWaitTimeInMinutes(start: CLLocationCoordinate2D) -> Int {
        return 9
    }
    
    func getPriceInDollars(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) -> Float {
        return 21
    }
    
    func orderCab(start: CLLocationCoordinate2D, creditCard: CreditCard?) -> Bool {
        return true
    }
    
}
