//
//  AppTrackingViewController.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import UIKit

class AppTrackingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AppTrackingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AppTrackTableViewCell.identifier) as! AppTrackTableViewCell
        if indexPath.row == 2 {
            cell.titleLabel.text = "Track Event \(indexPath.row) with parameter"
        } else {
            cell.titleLabel.text = "Track Event \(indexPath.row)"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tracker = PubStationSDK.getEventTracker()
        if indexPath.row == 2 {
            // Track app event with params.
            let trackingDict = ["Last": "This is the last event"]
            tracker.trackEvent("Event \(indexPath.row) tracked", params: trackingDict)
        } else {
            // Track app event.
            tracker.trackEvent("Event \(indexPath.row) tracked")
        }
    }
}
