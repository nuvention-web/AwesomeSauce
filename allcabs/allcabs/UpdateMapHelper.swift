//
//  UpdateHelper.swift
//  allcabs
//
//  Created by Matthew Albrecht on 5/28/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

class UpdateMapHelper{
    static func updateMyMarker(FVC : FirstViewController){
        var myMarker = FVC.myMarker
        if(myMarker == nil){
            myMarker = GMSMarker()
            
            //myMarker.icon = GMSMarker.markerImageWithColor(UIColor(red: 1, green: 0.4, blue: 0, alpha: 1))
            myMarker.title = "" //TODO
            myMarker.appearAnimation = kGMSMarkerAnimationNone
            
        }
        
        var red = CGFloat(min(FVC.deviationIndex, 1))
        var green = CGFloat(max(1-FVC.deviationIndex,0))
        
        myMarker.icon = GMSMarker.markerImageWithColor(UIColor(red: red, green: green, blue: CGFloat(0.0), alpha: CGFloat(1.0)))
        myMarker.position = FVC.currentCoord
        myMarker.map = FVC.mapView
    }
    
    static func updateMarker(mapView : GMSMapView!, marker : GMSMarker, position : CLLocationCoordinate2D, deviationIndex : Double!)->(){
        var red : CGFloat
        var green : CGFloat
        if let index = deviationIndex{
            red = CGFloat(min(index, 1))
            green = CGFloat(max(1-index,0))
        } else {
            red = CGFloat(0)
            green = CGFloat(1)
        }
        
        marker.icon = GMSMarker.markerImageWithColor(UIColor(red: red, green: green, blue: CGFloat(0.0), alpha: CGFloat(1.0)))
        marker.position = position
        marker.map = mapView
        
    }
    
    static func renderAllPaths(FVC : FirstViewController){
        FVC.mapView?.clear()
        for trackee : Trackee in FVC.trackees {
            let line = GMSPolyline(path: trackee.path)
            line.strokeWidth = 4.0
            line.tappable = true
            line.map = FVC.mapView
            
            let marker = GMSMarker()
            if let current_long = trackee.trackeeData["current_long"] as? NSString,
                current_lat = trackee.trackeeData["current_lat"] as? NSString,
                deviation_index = trackee.trackeeData["deviation_index"] as? NSString {
                    UpdateMapHelper.updateMarker(FVC.mapView, marker: marker, position: CLLocationCoordinate2D(latitude: current_lat.doubleValue,longitude: current_long.doubleValue), deviationIndex: deviation_index.doubleValue)
            }
        }
        
        UpdateMapHelper.updateMyMarker(FVC)
        let line = GMSPolyline(path: FVC.path)
        // 4
        line.strokeWidth = 4.0
        line.tappable = true
        line.map = FVC.mapView
    }
}
