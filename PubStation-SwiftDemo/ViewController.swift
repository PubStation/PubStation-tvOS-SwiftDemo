//
//  ViewController.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventTrackingStatusLabel: UILabel!
    @IBOutlet weak var enableLogsStatusLabel: UILabel!
    
    var enableEventTracking = true
    var enableLogs = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func eventTrackingClicked(sender: AnyObject) {
        enableEventTracking = !enableEventTracking
        // This method is used to enable / disable app event tracking. Default is true.
        // If this is set to false, no app related events will be tracked.
        PubStationSDK.setAllowEventTracking(enableEventTracking)
        if enableEventTracking {
            eventTrackingStatusLabel.text = "ON"
        } else {
            eventTrackingStatusLabel.text = "OFF"
        }
    }
    
    @IBAction func enableLogsClicked(sender: AnyObject) {
        enableLogs = !enableLogs
        // Optional: This method is used to Enable/Disable logs. Default is false.
        PubStationSDK.setEnableLogs(enableLogs)
        if enableLogs {
            enableLogsStatusLabel.text = "ON"
        } else {
            enableLogsStatusLabel.text = "OFF"
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.identifier) as! TableViewCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "Fetch Ad Automatically"
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "Fetch Ad Manually"
        } else {
            cell.titleLabel.text = "App Tracking"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let cntrl = UIStoryboard.viewControllerFromStoryboard(StoryBoard.main, id: AutoFetchViewController.identifier) as! AutoFetchViewController
            navigationController?.pushViewController(cntrl, animated: true)
        } else if indexPath.row == 1 {
            let cntrl = UIStoryboard.viewControllerFromStoryboard(StoryBoard.main, id: ManualFetchViewController.identifier) as! ManualFetchViewController
            navigationController?.pushViewController(cntrl, animated: true)
        } else {
            let cntrl = UIStoryboard.viewControllerFromStoryboard(StoryBoard.main, id: AppTrackingViewController.identifier) as! AppTrackingViewController
            navigationController?.pushViewController(cntrl, animated: true)
        }
    }
}