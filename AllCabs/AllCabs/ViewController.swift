//
//  ViewController.swift
//  AllCabs
//
//  Created by Farley Center on 2/1/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO
        //GetListOfCabCompanies
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

