//
//  ListViewController.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var pinYourselfButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: - Lifecycle Functions
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
        refreshTable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(activityIndicator)
        
        // TODO: Find a better solution to make activity indicator centered on tableview
        activityIndicator.center = CGPoint(x: view.frame.size.width/2, y: (view.frame.size.height/2 - NAV_BAR_AND_STATUS_BAR_HEIGHT))
    }
    
    // MARK: - Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentInformationArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentInformationCell", forIndexPath: indexPath)
        
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        cell.textLabel?.text = "\(appDelegate.studentInformationArray[indexPath.row].firstName) \(appDelegate.studentInformationArray[indexPath.row].lastName)"
        cell.detailTextLabel?.text = "\(appDelegate.studentInformationArray[indexPath.row].mediaURL)"
        cell.imageView?.image = UIImage(named: "location")
    }
    
    // MARK: - Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {
            print("No cell")
            return
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        openURL(cell.detailTextLabel?.text)
    }
    
    // MARK: - Actions
    @IBAction func logout(sender: UIBarButtonItem) {
        logout()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        refreshTable()
    }
    
    @IBAction func showPostingView(sender: UIBarButtonItem) {
        navigateToPostingView()
    }
    
    // MARK: - Helper Functions
    private func refreshTable() {
        setUIEnabled(false)
        scrollToFirstRow()
        getStudentLocationsData() {
            self.tableView.reloadData()
        }
        setUIEnabled(true)
    }
    
    private func scrollToFirstRow() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    private func setUIEnabled(enabled: Bool) {
        logoutButton.enabled = enabled
        pinYourselfButton.enabled = enabled
        refreshButton.enabled = enabled
    }

}
