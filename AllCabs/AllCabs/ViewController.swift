//
//  ViewController.swift
//  AllCabs
//
//  Created by Farley Center on 2/1/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cabCompanies : [CabCompany] = [CabCompany]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO
        //GetListOfCabCompanies
        let allCabsURL = ""
        cabCompanies.append(SideCar(imageURL: "\(allCabsURL)/sidecar.png", companyDescription: "The only app that will let you choose how much you pay, before your ride arrives"))
        cabCompanies.append(Lyft(imageURL: "\(allCabsURL)/lyft.png",
            companyDescription: "A ride whenever you need one"))
        cabCompanies.append(Norshore(imageURL: "\(allCabsURL)/norshore.png", companyDescription: "Clean professional service at reasonable, flat rates"))
        cabCompanies.append(UberBlack(imageURL: "\(allCabsURL)/uberblack.png", companyDescription: "Your own private driver, on demand. Expect pickup in a high-end sedan within minutes."))
        //GetInfoFromActiveCabCompanies
        //UpdateView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMessage() {
        let alertController = UIAlertController(title:"Welcome to the app",
            message: "Hello World",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title:"OK",
            style: UIAlertActionStyle.Default, handler: nil)
        )
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}

