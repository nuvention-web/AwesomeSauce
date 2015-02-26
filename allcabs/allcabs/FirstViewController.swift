//
//  FirstViewController.swift
//  allcabs
//
//  Created by Matt on 2/23/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager : CLLocationManager!
    var seenError : Bool = false
    var currentCoord : CLLocationCoordinate2D!
    var startingCoord : CLLocationCoordinate2D!
    var endingCoord : CLLocationCoordinate2D!
    var startedRoute : Bool = false
    var mapView : GMSMapView!
    let sydneyCoord : CLLocationCoordinate2D
    var menuButton : UIBarButtonItem!
    required init(coder aDecoder: NSCoder) {
        sydneyCoord = CLLocationCoordinate2D(latitude: -33.86,longitude: 151.20)
        super.init(coder: aDecoder)
        initLocationManager()

        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
            menuButton = self.navigationItem.leftBarButtonItem
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var camera = GMSCameraPosition.cameraWithTarget(sydneyCoord, zoom: 7)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        
        self.view = mapView
        
        var path = GMSMutablePath()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Location Manager helper stuff
    func initLocationManager() {
        seenError = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
    }
    
    // Location Manager Delegate stuff
    // If failed
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        
        if (currentCoord == nil){
            currentCoord = coord
            var camera = GMSCameraPosition.cameraWithTarget(mapView.myLocation.coordinate, zoom: 7)
            mapView.camera = camera
            
            startRoute()
            
        }
        currentCoord = coord
        
        

    }
    
    // authorization status
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Authorized:
                shouldIAllow = true
            default:
                shouldIAllow = false
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access")
            }
    }
    
    func fetchDirectionsFrom(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: ((String?) -> Void)) -> ()
    {
        var session = NSURLSession.sharedSession()
        let apiKey = "AIzaSyA7bZqH1O2yNky7qezL0d8KQYrMS1di9DY"
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?key=\(apiKey)&origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)"
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        session.dataTaskWithURL(NSURL(string: urlString)!) {data, response, error in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var encodedRoute: String?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? [String:AnyObject] {
                if let routes = json["routes"] as AnyObject? as? [AnyObject] {
                    if let route = routes.first as? [String : AnyObject] {
                        if let polyline = route["overview_polyline"] as AnyObject? as? [String : String] {
                            if let points = polyline["points"] as AnyObject? as? String {
                                encodedRoute = points
                            } else{
                                NSLog("No points")
                            }
                        } else {
                            NSLog("No polyline")
                        }
                    } else {
                        NSLog("No routes")
                    }
                    
                } else {
                    NSLog("No JSON routes")
                }
                NSLog(json.description)
            } else{
               NSLog("No JSON object")
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion(encodedRoute)
            }
            }.resume()
    }

    func startRoute(){
        endingCoord = CLLocationCoordinate2D(latitude: 37.3382,longitude: -121.8863)
        fetchDirectionsFrom(mapView.myLocation.coordinate, to: endingCoord) {optionalRoute in
            if let encodedRoute = optionalRoute {
                // 3
                let path = GMSPath(fromEncodedPath: encodedRoute)
                let line = GMSPolyline(path: path)
                
                // 4
                line.strokeWidth = 4.0
                line.tappable = true
                line.map = self.mapView
            }
        }
    }
}

