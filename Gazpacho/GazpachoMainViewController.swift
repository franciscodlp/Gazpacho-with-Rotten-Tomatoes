//
//  GazpachoMainViewController.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/7/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class GazpachoMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var segmentedControlContainerView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var layoutSegmentedControl: UISegmentedControl!
    
    var tableViewrefreshControl: UIRefreshControl!
    var collectionViewrefreshControl: UIRefreshControl!
    
    let topDVDURL = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")
    let boxOfficeURL = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")
    
    let customCellReuseIdentifier = "customCell"
    let dvdCustomCellReuseIdentifier = "dvdCustomCell"
    let boxCustomCellReuseIdentifier = "boxcustomCell"
    let collectionViewCellReuseIdentifier = "gridCell"
    
    var topDVDs: [AnyObject]?
    var boxOffice: [AnyObject]?
    var postersThumbnailsURL: [String]?

    var collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        println("viewDidLoad")
        super.viewDidLoad()
        postersThumbnailsURL = [String]?()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.hidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        layoutSegmentedControl.addTarget(self, action: "layoutSegmentedControlValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        tableViewrefreshControl = UIRefreshControl()
        collectionViewrefreshControl = UIRefreshControl()
        tableViewrefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionViewrefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(tableViewrefreshControl, atIndex: 0)
        self.collectionView.insertSubview(collectionViewrefreshControl, atIndex: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear")
        super.viewDidAppear(true)
        
        segmentedControlContainerView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        layoutSegmentedControl.selectedSegmentIndex = NSUserDefaults.standardUserDefaults().objectForKey("layoutSegmentedControllIndex") as? Int ?? 0
        
        //postersThumbnailsURL = [String]?()
        
        self.setLayOut()
        
        if self.tabBarController?.selectedIndex == 0 {
            self.loadTopDVDsDataFromServer()
        } else if self.tabBarController?.selectedIndex == 1 {
            self.loadBoxOfficeDataFromServer()
        }
        
        self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableView.reloadData() : self.collectionView.reloadData()
    }
    
    func layoutSegmentedControlValueChanged(sender: UISegmentedControl) {
        println("layoutSegmentedControlValueChanged")
        
        NSUserDefaults.standardUserDefaults().setObject(layoutSegmentedControl.selectedSegmentIndex, forKey: "layoutSegmentedControllIndex")
        
        self.setLayOut()
        
        self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableView.reloadData() : self.collectionView.reloadData()
    }
    
    func setLayOut() {
        println("Setting LayOut")
        
        if layoutSegmentedControl.selectedSegmentIndex == 0 {
            println("List Layout")
            tableView.hidden = false
            collectionView.hidden = true
            self.view.sendSubviewToBack(collectionView)
            self.view.bringSubviewToFront(tableView)
            self.view.bringSubviewToFront(segmentedControlContainerView)
        } else {
            println("Grid Layout")
            tableView.hidden = true
            collectionView.hidden = false
            self.view.sendSubviewToBack(tableView)
            self.view.bringSubviewToFront(collectionView)
            self.view.bringSubviewToFront(segmentedControlContainerView)
        }
        
    }
    
    func onRefresh() {
        println("onRefresh")
        self.tabBarController?.selectedIndex == 0 ? self.loadTopDVDsDataFromServer() : self.loadBoxOfficeDataFromServer()
        
    }
    
    
    func loadTopDVDsDataFromServer() {
        println(">> loadTopDVDsDataFromServer")
        var request = NSURLRequest(URL: topDVDURL!)
        
        if AFNetworkReachabilityManager.sharedManager().reachable {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.topDVDs = responseDictionary["movies"] as! [AnyObject]?
                
                self.postersThumbnailsURL = responseDictionary.valueForKeyPath("movies.posters.thumbnail") as! [String]?
                
                self.tableViewrefreshControl.endRefreshing()
                self.collectionViewrefreshControl.endRefreshing()
                
                self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableView.reloadData() : self.collectionView.reloadData()
            }
        } else {
            
            self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableViewrefreshControl.endRefreshing() : self.collectionViewrefreshControl.endRefreshing()
            
        }
        
    }
    
    func loadBoxOfficeDataFromServer() {
        if AFNetworkReachabilityManager.sharedManager().reachable {
        println(">> loadBoxOfficeDataFromServer")
        var request = NSURLRequest(URL: boxOfficeURL!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.boxOffice = responseDictionary["movies"] as! [AnyObject]?
                
                self.postersThumbnailsURL = responseDictionary.valueForKeyPath("movies.posters.thumbnail") as! [String]?
                
                self.tableViewrefreshControl.endRefreshing()
                self.collectionViewrefreshControl.endRefreshing()
                
                self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableView.reloadData() : self.collectionView.reloadData()
            }
        } else {
            self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableViewrefreshControl.endRefreshing() : self.collectionViewrefreshControl.endRefreshing()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepareForSegue")
        var vc = segue.destinationViewController as! GazpachoMovieDetailsViewController

        var indexPath = self.layoutSegmentedControl.selectedSegmentIndex == 0 ? self.tableView.indexPathForCell(sender as! UITableViewCell) : self.collectionView.indexPathForCell(sender as! UICollectionViewCell)
        
        if self.tabBarController?.selectedIndex == 0 {
            vc.movie = topDVDs?[indexPath!.row] as? NSDictionary
        }else {
            vc.movie = boxOffice?[indexPath!.row] as? NSDictionary
        }
    }


}

    // MARK: - UITableViewDataSource

extension GazpachoMainViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tabBarController!.selectedIndex == 0 {
            return topDVDs?.count ?? 0
        } else {
            return boxOffice?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("-- Cell For Row at Index --")
        
        let cell = tableView.dequeueReusableCellWithIdentifier(customCellReuseIdentifier, forIndexPath: indexPath) as! GazpachoCustomTableViewCell
        
        cell.posterThumb.setImageWithURL(NSURL(string: postersThumbnailsURL![indexPath.row])!)
        
        var data = self.tabBarController!.selectedIndex == 0 ? topDVDs : boxOffice
        
        cell.movieTitleLabel.text = (data?[indexPath.row])!["title"] as? String
        var audienceScore = ((data?[indexPath.row])!["ratings"] as! NSDictionary)["audience_score"] as? Int
        cell.audienceScoreLabel.text = "\(audienceScore!) %"
        var criticsScore = ((data?[indexPath.row])!["ratings"] as! NSDictionary)["critics_score"] as? Int
        cell.criticsScoreLabel.text = "\(criticsScore!) %"
        cell.mpaaRatingLabel.text = (data?[indexPath.row])!["mpaa_rating"] as? String
        var runtime = (data?[indexPath.row])!["runtime"] as? Int
        cell.runtimeLabel.text = "\(runtime!) min"
        
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension GazpachoMainViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.tabBarController!.selectedIndex == 0 {
            return topDVDs?.count ?? 0
        } else {
            return boxOffice?.count ?? 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellReuseIdentifier, forIndexPath: indexPath) as! GazpachoCustomCollectionViewCell
        
        collectionCell.posterImageView.setImageWithURL(NSURL(string: postersThumbnailsURL![indexPath.row])!)
        
        var data = self.tabBarController!.selectedIndex == 0 ? topDVDs : boxOffice
        
        collectionCell.bottomBackgroundView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        var audienceScore = ((data?[indexPath.row])!["ratings"] as! NSDictionary)["audience_score"] as? Int
        collectionCell.audienceScoreLabel.text = "\(audienceScore!)"
        var criticsScore = ((data?[indexPath.row])!["ratings"] as! NSDictionary)["critics_score"] as? Int
        collectionCell.criticsScoreLabel.text = "\(criticsScore!)"
        collectionCell.mpaaRatingLabel.text = (data?[indexPath.row])!["mpaa_rating"] as? String


        return collectionCell
    }

}

// MARK: - UICollectionViewDelegate

extension GazpachoMainViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GazpachoMainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - (10 * 3)) / 2 , height: 218)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
}
