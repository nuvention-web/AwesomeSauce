//
//  UpdateHelper.swift
//  allcabs
//
//  Created by Matthew Albrecht on 5/28/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

class UpdateMapHelper{
    static let rygArray = [UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: CGFloat(1.0)),
        UIColor(red: 222.0/255, green: 80.0/255, blue: 3.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 226.0/255, green: 122.0/255, blue: 29.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 230.0/255, green: 170.0/255, blue: 25.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 239.0/255, green: 206.0/255, blue: 16.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 224.0/255, green: 230.0/255, blue: 26.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 172.0/255, green: 214.0/255, blue: 42.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 128.0/255, green: 200.0/255, blue: 55.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 76.0/255, green: 168.0/255, blue: 43.0/255, alpha: CGFloat(1.0)),
        UIColor(red: 34.0/255, green: 139.0/255, blue: 34.0/255, alpha: CGFloat(1.0))]
    static func updateMyMarker(FVC : FirstViewController){
        var myMarker = FVC.myMarker
        if(myMarker == nil){
            myMarker = GMSMarker()
            
            //myMarker.icon = GMSMarker.markerImageWithColor(UIColor(red: 1, green: 0.4, blue: 0, alpha: 1))
            myMarker.title = FVC.name
            myMarker.appearAnimation = kGMSMarkerAnimationNone
            
        }
        
        var red = CGFloat(min(FVC.deviationIndex, 1))
        var green = CGFloat(max(1-FVC.deviationIndex,0))
        
        myMarker.icon = GMSMarker.markerImageWithColor(rygArray[9-Int(min(FVC.deviationIndex*10,9))])
        if let currentCoord = FVC.currentCoord{
            myMarker.position = FVC.currentCoord
        }
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
        
        marker.icon = GMSMarker.markerImageWithColor(rygArray[9-Int(min(deviationIndex*10,9))])
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
            if let name = trackee.trackeeData["name"] as? NSString{
                marker.title = name as String
            }
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
