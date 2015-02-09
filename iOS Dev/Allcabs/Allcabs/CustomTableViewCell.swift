//
//  CustomTableViewCell.swift
//  Allcabs
//
//  Created by Farley Center on 2/9/15.
//  Copyright (c) 2015 Farley Center. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    

    @IBOutlet weak var labelCompanyName: UILabel!

    @IBOutlet weak var labelTimenMoney: UILabel!

    @IBOutlet weak var imageViewCabPicture: UIImageView!
    @IBOutlet weak var labelCompanyInfo: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
