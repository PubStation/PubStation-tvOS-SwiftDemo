//
//  AutoFetchViewController.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import UIKit

class AutoFetchViewController: UIViewController {
    
    @IBOutlet weak var adInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Optional: Enable Logs. Default is false.
        // Commented here, since this is set in the main view controller.
        //PubStationSDK.setEnableLogs(true)
        
        // Initialize PubStation Interstitial Ad Manager with default settings
        let manager = PubStationSDK.getInterstitialAdManager()
        
        // Optional: Set user properties
        let user = PubStationSDK.getUser()
        user.gender = PSFemale
        
        // Optional: Set app properties
        let app = PubStationSDK.getApp()
        app.privacyPolicy = PSPrivacyNotProtected
        app.paid = PSAppNotPaid
        // Optional: Set here all categories that fit to your app.
        // For a full list see "5.1 Content Categories", p.30-40) in the OpenRTB doc:
        // http://www.iab.com/wp-content/uploads/2015/05/OpenRTB_API_Specification_Version_2_3_1.pdf
        app.category = [
            "IAB9-30", // Video & computer games
            "IAB17-34" // Skateboarding
        ]
        
        // Optional: Set the delegates
        manager.loadDelegate = self;
        manager.playDelegate = self;
        
        // Optional: Track user-defined app related events
        let tracker = PubStationSDK.getEventTracker()
        tracker.trackEvent("App Launched")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAdClicked(sender: AnyObject) {
        //This method is used to check if Ad is ready to be displayed.
        if PubStationSDK.getInterstitialAdManager().isAdReady() {
            // The user can see the ad when the below method is called.
            PubStationSDK.getInterstitialAdManager().showVideoAd()
        } else {
            adInfoLabel.text = "Ad is downloading. Please wait."
        }
    }
}

// If the Ad delegates are set, the callbacks would be obtained here
extension AutoFetchViewController: PSLoadAdDelegate, PSPlayAdDelegate {
    
    // MARK: LoadAdDelegates
    func interstitialAdManager(manager: PSInterstitialAdManager!, didStartDownloadAd ad: PSInterstitialAd!) {
        dispatch_async(dispatch_get_main_queue()) {
            if manager.isAdReady() {
                self.adInfoLabel.text = "Your Ad is ready. Hit the Show Ad button to play the Ad"
            } else {
                self.adInfoLabel.text = "Ad is downloading. Please wait."
            }
        };
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didCompleteDownloadAd ad: PSInterstitialAd!) {
        dispatch_async(dispatch_get_main_queue()) {
            self.adInfoLabel.text = "Your Ad is ready. Hit the Show Ad button to play the Ad"
        };
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didFailToDownloadAd ad: PSInterstitialAd!, withError error: NSError!) {
        self.adInfoLabel.text = "Failed to show Ad with error: \(error.localizedDescription)"
    }
    
    // MARK: PlayAdDelegates
    func interstitialAdManager(manager: PSInterstitialAdManager!, didClickOnAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didDismissAd ad: PSInterstitialAd!, withReason reason: PSVideoDismissReasonType) {
        if manager.isAdReady() {
            adInfoLabel.text = "Your Ad is ready. Hit the Show Ad button to play the Ad"
        } else {
            adInfoLabel.text = "Ad dismissed"
        }
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didCompleteAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didStartAdPlayback ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didReachMidPointOfAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didReachFirstQuartileOfAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didReachThirdQuartileOfAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didFailToPlayAd ad: PSInterstitialAd!, error: NSError!) {
        
    }
    
}

