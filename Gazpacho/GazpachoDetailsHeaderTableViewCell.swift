//
//  DetailsHeaderTableViewCell.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/7/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class GazpachoDetailsHeaderTableViewCell: UITableViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    
    @IBOutlet var movieYearLabel: UILabel!
    
    @IBOutlet var movieMpaaRatingLabel: UILabel!
    
    @IBOutlet var movieDurationLabel: UILabel!
    
    @IBOutlet var movieAudienceScoreLabel: UILabel!
    
    @IBOutlet var movieAudienceIcon: UIImageView!
    
    @IBOutlet var movieCriticsScoreLabel: UILabel!
    
    @IBOutlet var criticsIcon: UIImageView!
    
    @IBOutlet var likeItIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
