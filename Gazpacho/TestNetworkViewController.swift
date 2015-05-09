//
//  TestNetworkViewController.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/8/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class TestNetworkViewController: UIViewController {

    @IBAction func buttonPressed(sender: UIButton) {
    
    }
    
    @IBOutlet var switchReachability: UISwitch!
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        
        if switchReachability.on {
            AFNetworkReachabilityManager.sharedManager().startMonitoring()
        } else {
            AFNetworkReachabilityManager.sharedManager().stopMonitoring()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        AFNetworkReachabilityManager.sharedManager().startMonitoring()
//        
//        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status: AFNetworkReachabilityStatus) -> Void in
//            
//            print("Network status changed to ")
//            switch AFNetworkReachabilityManager.sharedManager().networkReachabilityStatus {
//            case AFNetworkReachabilityStatus.NotReachable:
//                println("Network not reachable")
//                GazpachoNetworkErrorHandler.displayErrorMessage(self, displayMessage: true)
//            case AFNetworkReachabilityStatus.Unknown:
//                GazpachoNetworkErrorHandler.displayErrorMessage(self, displayMessage: true)
//                println("Network reachability Unknown")
//            case AFNetworkReachabilityStatus.ReachableViaWWAN:
//                GazpachoNetworkErrorHandler.displayErrorMessage(self, displayMessage: false)
//                println("Network reachable via Cellular")
//            case AFNetworkReachabilityStatus.ReachableViaWiFi:
//                GazpachoNetworkErrorHandler.displayErrorMessage(self, displayMessage: false)
//                println("Network reachable via WiFi")
//            default:
//                GazpachoNetworkErrorHandler.displayErrorMessage(self, displayMessage: true)
//                println("ERROR: Reachability Status not recognized")
//            }
// 
//        }
        

        // Do any additional setup after loading the view.
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
