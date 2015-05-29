//
//  FirstViewController.swift
//  allcabs
//
//  Created by Matt on 2/23/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

//import UIKit
//import CoreLocation
import MessageUI

class FirstViewController: MenuViewController, CLLocationManagerDelegate, UISearchResultsUpdating, UISearchBarDelegate, MFMessageComposeViewControllerDelegate {
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
    var name : String = ""
    
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
        AppDelegate.firstViewController = self
        var camera = GMSCameraPosition.cameraWithTarget(sydneyCoord, zoom: 7)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        
        self.view = mapView
        
        var defaults = NSUserDefaults.standardUserDefaults()
        let userName = defaults.stringForKey("name")
        if let userName = userName{
            self.name = userName
        } else {
            MessageHelper.getUserName(self)
        }
        
        //This should be last
        if let action = AppDelegate.actionToTake{
            AppDelegate.actionToTake = nil
            UIApplication.sharedApplication().sendAction(action, to: self, from: nil, forEvent: nil)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func cancelCurrentRoute(){
        ShareModel.finishTrackingRoute(self, completionType: .Cancelled)
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
        struct staticHolder {
            static var lastTimeUpdated = NSDate()
        }
        if (currentCoord == nil && mapView?.myLocation?.coordinate != nil){
            currentCoord = coord
            var camera = GMSCameraPosition.cameraWithTarget(mapView.myLocation.coordinate, zoom: 9)
            mapView.camera = camera
            

            //startRoute()
            
        }
        self.currentCoord = coord
        if DeviationHelper.reachedDestination(self) {
            ShareModel.finishTrackingRoute(self, completionType: .Arrived)
            UpdateMapHelper.updateMyMarker(self)
            return
        }
        
        DeviationHelper.calculateDeviationIndex(self)
        
        if NSDate().secondsFrom(staticHolder.lastTimeUpdated) >= 10{
            staticHolder.lastTimeUpdated = NSDate()
            ShareModel.updateAllTrackees(self, completion:nil)
            if((ShareModel.uniqueuserid) != nil){
                ShareModel.updateRouteByID(ShareModel.uniqueuserid, sender: self,postData: nil, completion: nil)
            }
        }else if NSDate().secondsFrom(staticHolder.lastTimeUpdated) >= 5{
            UpdateMapHelper.renderAllPaths(self)
        }else {
            UpdateMapHelper.updateMyMarker(self)
        }
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
        if(mapView.myLocation != nil){
            self.startingCoord = CLLocationCoordinate2D(latitude: mapView.myLocation.coordinate.latitude, longitude: mapView.myLocation.coordinate.longitude)
        }
        fetchDirectionsFrom(mapView.myLocation?.coordinate, to: endingAddress) {optionalRoute in
            if let encodedRoute = optionalRoute {
                // 3
                self.mapView.clear()
                let path = GMSPath(fromEncodedPath: encodedRoute)
                self.path = path
                let line = GMSPolyline(path: path)
                DeviationHelper.calculateDeviationIndex(self);
                // 4
                line.strokeWidth = 4.0
                line.tappable = true
                line.map = self.mapView
                if self.demo {
                    self.fakeMarkerForDemo()
                }
                self.deviatedFromPath = false
                //trackNewRoute(completion: sendMessage)
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
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
            case MessageComposeResultCancelled.value:
                println("Message was cancelled")
                self.dismissViewControllerAnimated(true, completion: nil)
            case MessageComposeResultFailed.value:
                println("Message failed")
                self.dismissViewControllerAnimated(true, completion: nil)
            case MessageComposeResultSent.value:
                println("Message was sent")
                self.dismissViewControllerAnimated(true, completion: nil)
            default:
                break;
        }
    }
    
    func shareRoute(){
        var id = ShareModel.uniqueuserid
        if id == nil{
            ShareModel.startNewRoute(self){
                id = ShareModel.uniqueuserid
                MessageHelper.sendMessage(self, trackingID: id, FVC: self)
            }
        }
        else {
            MessageHelper.sendMessage(self, trackingID: id, FVC: self)
        }

    }
    
    var trackees : [Trackee] = [Trackee]()
    
    
    @IBAction func trackNewID(sender : AppDelegate){
        var id = AppDelegate.id
        if !arrayContainsTrackee(id){
            var trackee : Trackee = Trackee(id : id)
            trackees.append(trackee)
        }
    }
    
    func arrayContainsTrackee(id : String) -> (Bool){
        for trackee : Trackee in trackees{
            if trackee.id == id{
                return true
            }
        }
        return false
    }
    
}


