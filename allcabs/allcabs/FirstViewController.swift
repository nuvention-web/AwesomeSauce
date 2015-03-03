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

class FirstViewController: MenuViewController, CLLocationManagerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    var locationManager : CLLocationManager!
    var seenError : Bool = false
    var currentCoord : CLLocationCoordinate2D!
    var startingCoord : CLLocationCoordinate2D!
    //var endingCoord : CLLocationCoordinate2D!
    var endingAddress : String!
    var startedRoute : Bool = false
    var mapView : GMSMapView!
    let sydneyCoord : CLLocationCoordinate2D
    var menuButton : UIBarButtonItem!
    let apiKey = "AIzaSyA7bZqH1O2yNky7qezL0d8KQYrMS1di9DY"
    var searchController : UISearchController!
    var googlePlacesAutocompleteViewController : GooglePlacesAutocompleteViewController!
    let demoPosition = CLLocationCoordinate2D(latitude: 37.8044,longitude: -122.1608)
    let demo : Bool = true
    required override init(coder aDecoder: NSCoder) {
        sydneyCoord = CLLocationCoordinate2D(latitude: -33.86,longitude: 151.20)
        super.init(coder: aDecoder)
        initLocationManager()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    


     override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchController();
        
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
    
    func loadSearchController() {
        googlePlacesAutocompleteViewController = storyboard?.instantiateViewControllerWithIdentifier("googlePlacesAutocompleteViewController") as GooglePlacesAutocompleteViewController
        self.searchController = UISearchController(searchResultsController: googlePlacesAutocompleteViewController)
        self.searchController.searchResultsUpdater = self;
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchBar = searchController.searchBar
        self.searchBar.placeholder = "Destination"
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        self.searchBar.delegate = self
        
        googlePlacesAutocompleteViewController.searchController = self.searchController
        
        
    }
    
    // Location Manager Delegate stuff
    // If failed
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        //locationManager.stopUpdatingLocation()
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
        
        if (currentCoord == nil && mapView?.myLocation?.coordinate != nil){
            currentCoord = coord
            var camera = GMSCameraPosition.cameraWithTarget(mapView.myLocation.coordinate, zoom: 9)
            mapView.camera = camera
            
            //startRoute()
            
        }
        
        

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
                NSLog("Location Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access")
            }
    }
    
    func fetchDirectionsFrom(from: CLLocationCoordinate2D?, to: String, completion: ((String?) -> Void)) -> ()
    {
        
        var session = NSURLSession.sharedSession()
        if let unwrappedFrom = from{
            let urlString = "https://maps.googleapis.com/maps/api/directions/json?key=\(apiKey)&origin=\(unwrappedFrom.latitude),\(unwrappedFrom.longitude)&destination=\(to)"
            if let encodedURL = (urlString as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) as String?{
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                    session.dataTaskWithURL(NSURL(string: encodedURL)!) {data, response, error in
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                            var encodedRoute: String?
                            if let json = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? [String:AnyObject] {
                                    if let routes = json["routes"] as AnyObject? as? [AnyObject] {
                                            if let route = routes.first as? [String : AnyObject] {
                                                    if let polyline = route["overview_polyline"] as AnyObject? as? [String : String] {
                                                            if let points = polyline["points"] as AnyObject? as? String {
                                                                    encodedRoute = points
                                                            }
                                                    }
                                            }
                                    }
                                    //NSLog(json.description)
                            }
                            dispatch_async(dispatch_get_main_queue()) {
                                    completion(encodedRoute)
                            }
                        }.resume()
                }
            }
    }

    func startRoute(){
        //endingCoord = CLLocationCoordinate2D(latitude: 37.3382,longitude: -121.8863)
        fetchDirectionsFrom(mapView.myLocation?.coordinate, to: endingAddress) {optionalRoute in
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var searchString = searchController.searchBar.text
        if let viewController = googlePlacesAutocompleteViewController{
            self.getPlaces(searchString) { places in
                if let placeArray = places {
                    viewController.places = placeArray
                    viewController.tableView.reloadData()
                }
            }
        }
        
    }
    
    private func getPlaces(searchString: String, completion:([String]?->Void)) -> (){
        var session = NSURLSession.sharedSession()
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=\(apiKey)&input=\(searchString)"
        let escapedString = (urlString as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) as String?
        var places = [String]()
        let myURL = NSURL(string: escapedString!)
        if let url = myURL{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            session.dataTaskWithURL(url) {data, response, error in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                var encodedRoute: String?
                if let response = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? [String: AnyObject] {
                    if let predictions = response["predictions"] as? Array<AnyObject> {
                        places = predictions.map { (prediction: AnyObject) -> String in
                            return prediction["description"] as String
                        }
                    }
                    //NSLog(response.description)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    completion(places)
                }
            }.resume()
            
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NSLog("Search button clicked")
        endingAddress = searchBar.text
        startRoute()
        if countElements(self.searchBar.text) > 36 {
            self.searchBar.text = self.searchBar.text.substringToIndex(advance(self.searchBar.text.startIndex,35))
        }
        self.searchBar.placeholder = self.searchBar.text
        self.searchController.active = false
        if demo {
            fakeMarkerForDemo()
        }
    }
    
    func fakeMarkerForDemo(){
        var marker = GMSMarker()
        marker.position = demoPosition
        marker.icon = GMSMarker.markerImageWithColor(UIColor(red: 1, green: 0.4, blue: 0, alpha: 1))
        marker.title = "Matthew"
        marker.map = mapView
        
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: currentCoord.latitude - 0.2, longitude: currentCoord.longitude)
        marker.icon = GMSMarker.markerImageWithColor(UIColor(red: 0, green: 0.9, blue: 0, alpha: 1))
        marker.map = mapView
    }

}


