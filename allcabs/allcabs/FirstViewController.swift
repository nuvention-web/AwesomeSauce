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
    var deviatedFromPath : Bool = false
    var mapView : GMSMapView!
    var myMarker: GMSMarker!
    let sydneyCoord : CLLocationCoordinate2D
    var menuButton : UIBarButtonItem!
    let apiKey = "AIzaSyA7bZqH1O2yNky7qezL0d8KQYrMS1di9DY"
    var searchController : UISearchController!
    var googlePlacesAutocompleteViewController : GooglePlacesAutocompleteViewController!
    //let demoPosition = CLLocationCoordinate2D(latitude: 37.8044,longitude: -122.1608) //42.0518189,-87.6894447
    let demoPosition = CLLocationCoordinate2D(latitude: 41.9000,longitude: -87.6894)
    let demo : Bool = true
    var deviationIndex : Double
    var path : GMSPath!
    
    required init(coder aDecoder: NSCoder) {
        //sydneyCoord = CLLocationCoordinate2D(latitude: -33.86,longitude: 151.20)
        sydneyCoord = CLLocationCoordinate2D(latitude: 41.9000,longitude: -87.6894)
        deviationIndex = 0.0
        super.init(coder: aDecoder)
        initLocationManager()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    


     override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchController()
        setupNotificationSettings()
        
        var camera = GMSCameraPosition.cameraWithTarget(sydneyCoord, zoom: 7)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        
        self.view = mapView
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func calculateDeviationIndex()->() {
        var path = self.path
        if path == nil{
            return
        }
        let length = path.lengthOfKind(kGMSLengthGeodesic) * 0.000621371; // in miles
        var minDistance : Double = 9999999;
        var distance = 0.01
        if path.count() > 1{

            while (!GMSGeometryIsLocationOnPathTolerance(self.currentCoord, path, true, distance/0.000621371)){
                distance *= 1.5
            }
            distance /= 1.5
        }
        deviationIndex = (length > 1) ? distance / pow(length,0.65) : distance / length
        if (deviationIndex > 1 && !deviatedFromPath){
            deviatedFromPath = true
            sendDeviatedAlert()
        }
    }
    
    func sendDeviatedAlert(){
        
        //Send alert
        var localNotification = UILocalNotification()
        localNotification.fireDate = nil //Fire immediately
        localNotification.alertBody = "You have significantly deviated from your expected path!"
        localNotification.alertAction = "View Map" //Action when swiping alert
        localNotification.category = "devaitionAlertCategory"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    
    func cancelCurrentRoute(){
        deviationIndex = 0.0
        path = nil
        self.mapView.clear()
        self.deviatedFromPath = false
    }
    
    func setupNotificationSettings(){
        let notificationSettings: UIUserNotificationSettings! = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if (notificationSettings.types != UIUserNotificationType.None){
            //No need to setup everything twice
            return
        }
        // Specify the notification types.
        var notificationTypes: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        
        // Specify the notification actions.
        var justInformAction = UIMutableUserNotificationAction()
        justInformAction.identifier = "justInform"
        justInformAction.title = "OK, got it"
        justInformAction.activationMode = UIUserNotificationActivationMode.Background
        justInformAction.destructive = false
        justInformAction.authenticationRequired = false
        
        var viewMapAction = UIMutableUserNotificationAction()
        viewMapAction.identifier = "viewMap"
        viewMapAction.title = "View Map"
        viewMapAction.activationMode = UIUserNotificationActivationMode.Foreground
        viewMapAction.destructive = false
        viewMapAction.authenticationRequired = false
    
        let actionsArray = NSArray(objects: viewMapAction, justInformAction)
        var deviationAlertCategory = UIMutableUserNotificationCategory()
        deviationAlertCategory.identifier = "deviationAlertCategory"
        deviationAlertCategory.setActions(actionsArray as [AnyObject], forContext: UIUserNotificationActionContext.Default)
        
        let categoriesForSettings = NSSet(objects: deviationAlertCategory)
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings as Set<NSObject>)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
        
    }
    
    func updateMyMarker()->(){
        if path == nil{
            return
        }
        
        var red = CGFloat(min(deviationIndex, 1))
        var green = CGFloat(max(1-deviationIndex,0))
        if(myMarker == nil){
            myMarker = GMSMarker()

            //myMarker.icon = GMSMarker.markerImageWithColor(UIColor(red: 1, green: 0.4, blue: 0, alpha: 1))
            myMarker.title = "Matthew"
            myMarker.appearAnimation = kGMSMarkerAnimationNone

        }
        myMarker.icon = GMSMarker.markerImageWithColor(UIColor(red: red, green: green, blue: CGFloat(0.0), alpha: CGFloat(1.0)))
        myMarker.position = self.currentCoord
        myMarker.map = self.mapView
        
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
        googlePlacesAutocompleteViewController = storyboard?.instantiateViewControllerWithIdentifier("googlePlacesAutocompleteViewController") as! GooglePlacesAutocompleteViewController
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
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        
        if (currentCoord == nil && mapView?.myLocation?.coordinate != nil){
            currentCoord = coord
            var camera = GMSCameraPosition.cameraWithTarget(mapView.myLocation.coordinate, zoom: 9)
            mapView.camera = camera
            

            //startRoute()
            
        }
        self.currentCoord = coord
        calculateDeviationIndex()
        updateMyMarker()
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.AuthorizedAlways:
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
                self.mapView.clear()
                let path = GMSPath(fromEncodedPath: encodedRoute)
                self.path = path
                let line = GMSPolyline(path: path)
                self.calculateDeviationIndex();
                // 4
                line.strokeWidth = 4.0
                line.tappable = true
                line.map = self.mapView
                if self.demo {
                    self.fakeMarkerForDemo()
                }
                self.deviatedFromPath = false
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
                            return prediction["description"] as! String
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
        if count(self.searchBar.text) > 36 {
            self.searchBar.text = self.searchBar.text.substringToIndex(advance(self.searchBar.text.startIndex,35))
        }
        self.searchBar.placeholder = self.searchBar.text
        self.searchController.active = false
    }
    
    func fakeMarkerForDemo(){


    }

}


