//
//  friendList.swift
//  allcabs
//
//  Created by Farley Center on 2/27/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import Foundation
import UIKit


class friendListCell :UITableViewCell
{
    
    @IBOutlet weak var FriendListSwitch: UISwitch!
    @IBOutlet weak var FriendListImage: UIImageView!
    @IBOutlet weak var FriendListName: UILabel!
    
    func LoadCell(CellImage :UIImage, CellName: String)
    {
        FriendListImage.image = CellImage
        FriendListName.text = CellName
        FriendListSwitch.setOn(false, animated: true)
    }
}


class friendList : UIViewController,UITableViewDataSource, UITableViewDelegate
{
    override func viewDidLoad() {
        
        FriendListTable.delegate = self;
        FriendListTable.dataSource = self;
        //self.FriendListTable.registerNib(UINib(nibName: "friendListCell", bundle: nil) , forCellReuseIdentifier: "cell")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var name : [String] = ["Reshu","Matthew","Richard", "James","Patricia"]
    var profilepics : [UIImage] = [UIImage(named: "Reshu.jpg")!,UIImage(named: "Matthew.jpg")!,UIImage(named: "Patricia.jpg")!,UIImage(named: "Richard.jpg")!,UIImage(named: "James.jpg")!]
    

//    var nib = UINib(nibName: "friendListCell", bundle: nil)
    
    
    @IBOutlet weak var FriendListTable: UITableView!
    
    func tableView(FriendListTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : friendListCell = FriendListTable.dequeueReusableCellWithIdentifier("cell") as friendListCell
//        FriendListTable.registerNib(nib, forCellReuseIdentifier: "cell")
        cell.LoadCell(profilepics[indexPath.row], CellName: name[indexPath.row])
        return cell
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
}