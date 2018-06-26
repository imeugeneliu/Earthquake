//
//  earthquakeInfoTableViewCell.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/16/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit

class earthquakeInfoTableViewCell: UITableViewCell
{

    @IBOutlet weak var magnitudeLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var depthLbl: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
