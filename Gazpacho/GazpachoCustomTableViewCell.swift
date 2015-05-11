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

        if selected {
            self.contentView.backgroundColor = UIColor(red: (245.0 / 255.0), green: (166.0 / 255.0), blue: (35.0 / 255.0), alpha: 1)
        } else {
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            
            self.contentView.backgroundColor = UIColor(red: (245.0 / 255.0), green: (166.0 / 255.0), blue: (35.0 / 255.0), alpha: 1)
            posterThumb.transform = CGAffineTransformMakeScale(0.1, 0.1)
            movieTitleLabel.transform = CGAffineTransformMakeScale(0.1, 0.1)
            UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.posterThumb.transform = CGAffineTransformIdentity
                self.movieTitleLabel.transform = CGAffineTransformIdentity
                }, completion: { (success:Bool) -> Void in
                    println("mola")
            })
        } else {
            
            self.contentView.backgroundColor = UIColor.whiteColor()
            
        }
    }
    

}
