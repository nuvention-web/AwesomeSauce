//
//  GooglePlacesAutocompleteViewController.swift
//  allcabs
//
//  Created by Farley Center on 3/1/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import UIKit
class GooglePlacesAutocompleteViewController : UITableViewController, UITableViewDelegate{
    var places = [String]()
    var searchController : UISearchController!
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tableView.opaque = false
        self.tableView.alpha = 0.6
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = true
        self.places = ["Alabama", "Arkansas", "Good enough"]
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("placesCell", forIndexPath: indexPath) as! UITableViewCell
        
        let place = self.places[indexPath.row]
        
        cell.textLabel!.text = place
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let searchBar = searchController?.searchBar {
            searchBar.text = places[indexPath.row]
            searchBar.delegate?.searchBarSearchButtonClicked!(searchBar)
        } else {
            NSLog("No search bar...")
        }
    }

}
