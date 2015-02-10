//
//  CreditCard.swift
//  AllCabs
//
//  Created by Farley Center on 2/5/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation

class CreditCard {
    let number : Int
    let nameOnCard : String?
    let securityCode : Int?
    let expirationMonth : Int?
    let expirationYear : Int?
    
    init(number: Int, nameOnCard : String?, securityCode : Int?,
            expirationMonth : Int?, expirationYear : Int?){
        
        self.number = number
        self.nameOnCard = nameOnCard
        self.securityCode = securityCode
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
            
    }
    
}