//
//  ManualFetchViewController.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import UIKit

class ManualFetchViewController: UIViewController {
    
    @IBOutlet weak var adInfoLabel: UILabel!
    @IBOutlet weak var showAdButton: UIButton!
    @IBOutlet weak var fetchAdButton: UIButton!
    
    var focusView: UIView? {
        didSet {
            setNeedsFocusUpdate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Optional: Enable Logs. Default is false.
        // Commented here, since this is set in the main view controller.
        //PubStationSDK.setEnableLogs(true)
        
        // Initialize settings for manual fetching of ad.
        let settings = PubStationSDKSettings()
        settings.autoDownloadVideoAd = false
        PubStationSDK.initializeWithSettings(settings)
        
        // Get Interstitial Ad Manager
        let manager = PubStationSDK.getInterstitialAdManager()

        /// Optional: Set user properties
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
                
        // Optional: Track app related events
        let tracker = PubStationSDK.getEventTracker()
        tracker.trackEvent("App Launched")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredFocusedView: UIView? {
        return focusView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showAdButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        if PubStationSDK.getInterstitialAdManager().isAdReady() {
            focusView = showAdButton
        } else {
            showAdButton.enabled = false
        }
    }
    
    @IBAction func fetchAdClicked(sender: AnyObject) {
        // Fetch new Ad.
        PubStationSDK.getInterstitialAdManager().fetchNewAd()
    }
    
    @IBAction func showAdClicked(sender: AnyObject) {
        //This method is used to check if Ad is ready to be displayed.
        if PubStationSDK.getInterstitialAdManager().isAdReady() {
            // The user can see the ad when the below method is called.
            PubStationSDK.getInterstitialAdManager().showVideoAd()
        }
    }
}

// If the Ad delegates are set, the callbacks would be obtained here
extension ManualFetchViewController: PSLoadAdDelegate, PSPlayAdDelegate {
    
    // MARK: LoadAdDelegate
    func interstitialAdManager(manager: PSInterstitialAdManager!, didStartDownloadAd ad: PSInterstitialAd!) {
        dispatch_async(dispatch_get_main_queue()) {
            if manager.isAdReady() {
                self.adInfoLabel.text = "Your Ad downloaded. Click Fetch Ad to download another Ad or click Show Ad button to display the Ad"
            } else {
                self.adInfoLabel.text = "Your Ad is downloading. Please wait"
            }
        };
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didCompleteDownloadAd ad: PSInterstitialAd!) {
        showAdButton.enabled = true
        focusView = showAdButton
            adInfoLabel.text = "Your Ad downloaded. Click Fetch Ad to download another Ad or click Show Ad button to display the Ad"
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didFailToDownloadAd ad: PSInterstitialAd!, withError error: NSError!) {
        adInfoLabel.text = "Your Ad failed to download with error: \(error.localizedDescription)"
    }
    
    // MARK: PlayAdDelegates
    func interstitialAdManager(manager: PSInterstitialAdManager!, didClickOnAd ad: PSInterstitialAd!) {
        
    }
    
    func interstitialAdManager(manager: PSInterstitialAdManager!, didDismissAd ad: PSInterstitialAd!, withReason reason: PSVideoDismissReasonType) {
        if manager.isAdReady() {
            adInfoLabel.text = "Ad ready.click Show Ad"
        } else {
            focusView = fetchAdButton
            adInfoLabel.text = "Ad Dismissed. Click Fetch Ad to download another Ad"
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


