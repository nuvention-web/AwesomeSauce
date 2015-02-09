//
//  ViewController.swift
//  Allcabs
//
//  Created by Farley Center on 2/8/15.
//  Copyright (c) 2015 Farley Center. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items: NSArray!
//    var item : string[][] = [["Sidecar","15 Mins","20$"],["Norshore","5 Mins","18$"],["Flashcab","10 Mins","22$"]]
    var companyName : [NSString] = ["Sidecar","Lyft","Uber","Flash"]
    var companyInfo : [NSString] = ["Fast and Cheap","Safe","Leaders","Quick"]
    var timenMoney : [NSString] = ["15min/20$","15min/20$","15min/20$","15min/20$"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
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
        return 4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        
//        cell.textLabel?.text = self.items[indexPath.row] as NSString
        cell.labelCompanyInfo.text = companyInfo[indexPath.row] as NSString
        cell.labelCompanyName.text = companyName[indexPath.row] as NSString
        cell.labelTimenMoney.text = timenMoney[indexPath.row] as NSString
        cell.imageViewCabPicture.image = UIImage(named: "cab.jpeg")
//        println()
//        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cab.png"]];
//        cell.back = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cabs.png"]];
//            cell.imageView?.image=UIImage(named: "cabs.png")
        
        return cell
        
    }


}

