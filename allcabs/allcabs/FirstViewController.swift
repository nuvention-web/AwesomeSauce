//
//  FirstViewController.swift
//  allcabs
//
//  Created by Farley Center on 2/23/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

