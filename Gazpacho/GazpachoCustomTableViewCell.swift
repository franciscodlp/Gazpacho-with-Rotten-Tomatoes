//
//  GazpachoCustomTableViewCell.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/7/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class GazpachoCustomTableViewCell: UITableViewCell {

    @IBOutlet var posterThumb: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    
    @IBOutlet var audienceScoreLabel: UILabel!
    
    @IBOutlet var criticsScoreLabel: UILabel!
    
    @IBOutlet var mpaaRatingLabel: UILabel!
    
    @IBOutlet var runtimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
