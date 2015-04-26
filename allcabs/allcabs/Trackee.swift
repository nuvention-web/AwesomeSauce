//
//  Trackee.swift
//  allcabs
//
//  Created by Reshu Goel on 4/25/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation

class Trackee {
    var path : GMSPath!
    var id : String
    var trackeeData : NSDictionary!
    
    init(id : String){
        self.id = id
    }
}