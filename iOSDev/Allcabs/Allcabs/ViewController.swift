//
//  ViewController.swift
//  Allcabs
//
//  Created by Farley Center on 2/8/15.
//  Copyright (c) 2015 Farley Center. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items: NSArray!
//    var item : string[][] = [["Sidecar","15 Mins","20$"],["Norshore","5 Mins","18$"],["Flashcab","10 Mins","22$"]]
    var cabCompanies : [CabCompany] = [CabCompany]()
    /*var companyName : [NSString] = ["Sidecar","Lyft","Uber","Flash"]
    var companyInfo : [NSString] = ["Fast and Cheap","Safe","Leaders","Quick"]
    var timenMoney : [NSString] = ["15min/20$","15min/20$","15min/20$","15min/20$"]*/
    
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 90, longitude: 90)
    var imageCache : [String :  UIImage] = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allCabsURL = ""
        let lyftURL = "http://latransplant.com/wp-content/uploads/2014/04/lyft-logo.jpg"
        let sidecarURL = "http://a2.mzstatic.com/us/r30/Purple/v4/cb/b2/10/cbb21035-4402-236d-92ec-cc11a52b2c52/mzl.owsfivfs.png"
        let uberURL = "http://www.taximobility.com/blog/wp-content/uploads/2014/12/uber.png"
        let norshoreURL = "http://a4.mzstatic.com/us/r30/Purple4/v4/4a/5f/97/4a5f978f-c178-a568-c6af-1bb832de7b8b/icon175x175.png"
        cabCompanies.append(SideCar(imageURL: "\(sidecarURL)", companyDescription: "The only app that will let you choose \nhow much you pay, before your ride arrives",companyName:"Sidecar"))
        cabCompanies.append(Lyft(imageURL: "\(lyftURL)",
            companyDescription: "A ride whenever you need one",companyName:"Lyft"))
        cabCompanies.append(Norshore(imageURL: "\(norshoreURL)", companyDescription: "Clean professional service at \nreasonable, flat rates",companyName:"Norshore"))
        cabCompanies.append(UberBlack(imageURL: "\(uberURL)", companyDescription: "Your own private driver, on demand. \nExpect pickup in a high-end sedan within minutes.",companyName: "Uber Black"))
        
        tableView.delegate = self;
        tableView.dataSource = self;
        //tableView.backgroundColor = UICol
        self.items = ["","one","two","three","four"]
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil) , forCellReuseIdentifier: "cell")
//        self.tableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cabCompanies.count;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        
//        cell.textLabel?.text = self.items[indexPath.row] as NSString
        cell.labelCompanyInfo.text = cabCompanies[indexPath.row].getCompanyDescription() as NSString
        cell.labelCompanyName.font = UIFont(name: "Helvetica", size: 25)
        
        cell.labelCompanyName.text = cabCompanies[indexPath.row].getCompanyName() as NSString
        cell.labelTimenMoney.font = UIFont(name: "Helvetica", size: 12)
        cell.labelTimenMoney.text = "\(cabCompanies[indexPath.row].getCabWaitTimeInMinutes(currentLocation))/$\(cabCompanies[indexPath.row].getPriceInDollars(currentLocation, end: currentLocation))" as NSString
        cell.imageViewCabPicture.image = cabCompanies[indexPath.row].getThumbnail(&imageCache)

        //        println()
//        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cab.png"]];
//        cell.back = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cabs.png"]];
//            cell.imageView?.image=UIImage(named: "cabs.png")
       
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.lightGrayColor()}
        else
        {cell.backgroundColor = UIColor.grayColor()}
        
        return cell
        
    }


}

