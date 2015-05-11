//
//  GazpachoMovieDetailsViewController.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/7/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class GazpachoMovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var movie: NSDictionary?
    var abridged_cast: [NSDictionary]?
    var characters: [[String]?] = [[String]?]()
    var name: [String]?
    var lowResPosterURL: String = ""
    var highResPosterURL: String = ""
    var placeHolderImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    
    override func viewDidLoad() {
        println("GazpachoMovieDetailsViewController: viewDidLoad")
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        abridged_cast = movie!.valueForKey("abridged_cast") as? [NSDictionary]
        for item in abridged_cast! {
            characters.append(item.valueForKey("characters") as! [String]?)
        }
        name = movie!.valueForKeyPath("abridged_cast.name") as! [String]?
        
        lowResPosterURL = movie!.valueForKeyPath("posters.original") as! String
        
        var range = lowResPosterURL.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        
        if let range = range {
            highResPosterURL = lowResPosterURL.stringByReplacingCharactersInRange(range, withString: "http://content6.flixster.com/")
        }
        
        tableView.backgroundView = placeHolderImage

        var tempImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.backgroundView!.frame.size.width, height: self.tableView.backgroundView!.frame.size.height))
        var request = NSURLRequest(URL: NSURL(string: highResPosterURL)!)

        tempImageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in

            tempImageView.image = image
            if response != nil {
                tempImageView.alpha = 0
                tempImageView.frame.origin = self.tableView.frame.origin
                self.tableView.backgroundView?.addSubview(tempImageView)
                self.tableView.backgroundView?.bringSubviewToFront(tempImageView)
                
                UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    (self.tableView.backgroundView!.subviews[0] as! UIImageView).alpha = 1
                    }, completion: { (success:Bool) -> Void in
                    self.tableView.backgroundView = tempImageView
                })
            } else {
                self.tableView.backgroundView = tempImageView
            }
            }, failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
                println(error)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

    // MARK: - UITableViewDataSource

extension GazpachoMovieDetailsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 2:
            return "Synopsis"
        case 3:
            return "Casting"
        case 4:
            return "Other Info"
        default:
            return nil
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return characters.count
        case 4:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("--- CELL ---")

        if indexPath.section == 0 {
            println("--- 0 ---")
            let cell = tableView.dequeueReusableCellWithIdentifier("headerSection", forIndexPath: indexPath) as! UITableViewCell
            
            tableView.rowHeight = 320
            
            cell.backgroundColor = UIColor.clearColor()
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
            
        } else if indexPath.section == 1 {
            println("--- 1 ---")
            let cell = tableView.dequeueReusableCellWithIdentifier("panelSection") as! GazpachoDetailsHeaderTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            tableView.rowHeight = 130
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            
            cell.movieAudienceIcon.image = UIImage(named: "PopcornIcon")
            cell.criticsIcon.image = UIImage(named: "TomatoeIcon")
            cell.likeItIcon.image = UIImage(named: "HeartOnlyIcon")
            
            cell.movieAudienceIcon.frame = CGRect(origin: cell.movieAudienceIcon.frame.origin, size: CGSize(width: 40, height: 39))
            cell.criticsIcon.frame = CGRect(origin: cell.criticsIcon.frame.origin, size: CGSize(width: 40, height: 39))
            cell.likeItIcon.frame = CGRect(origin: cell.likeItIcon.frame.origin, size: CGSize(width: 40, height: 39))
            
            var audienceScore = movie!.valueForKeyPath("ratings.audience_score") as? Int
            cell.movieAudienceScoreLabel.text = "\(audienceScore!)%"
            
            var criticsScore = movie!.valueForKeyPath("ratings.critics_score") as? Int
            cell.movieCriticsScoreLabel.text = "\(criticsScore!)%"
            
            cell.movieTitleLabel.text = movie!["title"] as? String
            var year = movie!["year"] as? Int
            cell.movieYearLabel.text = "\(year!)"
            cell.movieMpaaRatingLabel.text = movie!["mpaa_rating"] as? String
            var duration = movie!["runtime"] as? Int
            cell.movieDurationLabel.text = "\(duration!) min"

            return cell
            
        } else if indexPath.section == 2 {
            println("--- 2 ---")
            let cell = tableView.dequeueReusableCellWithIdentifier("synopsisSection", forIndexPath: indexPath) as! UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            tableView.rowHeight = 130
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            
            var text = UITextView(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
            
            text.text = movie!["synopsis"] as? String
            
            cell.contentView.addSubview(text)
            
            return cell
            
        } else if indexPath.section == 3 {
            println("--- 3 ---")
            let cell = tableView.dequeueReusableCellWithIdentifier("castingSection", forIndexPath: indexPath) as! UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            tableView.rowHeight = 50
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = name![indexPath.row] as String
            
            cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
            
            var charNames = characters[indexPath.row] as [String]?
            
            if charNames != nil {
                cell.detailTextLabel?.text = "as " + (charNames![0] as String)
            } else {
                cell.detailTextLabel?.text = "as " + "-"
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("otherSection", forIndexPath: indexPath) as! UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            tableView.rowHeight = 50
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            
            return cell
        }
        
    }
    
}

// MARK: - UITableViewDelegate

extension GazpachoMovieDetailsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 50
        case 3:
            return 50
        case 4:
            return 50
        default:
            return 0
        }
    }
    
}