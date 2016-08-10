//
//  BaseViewController.swift
//  On The Map
//
//  Created by Ali Kayhan on 29/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

// MARK: - Base View Controller
// This class contains the properties and methods used commonly across other View Controllers.
class BaseViewController: UIViewController {
    
    // MARK: - Properties
    var activityIndicator : UIActivityIndicatorView!
    
    // MARK: - Constant Propery
    let NAV_BAR_AND_STATUS_BAR_HEIGHT: CGFloat = 64
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
    }
    
    // MARK: - Alert Method
    func showAlert(title: String, message: String? = nil, customActions: [UIAlertAction]? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        if customActions == nil {
            alertController.addAction(okAction)
        } else {
            for action in customActions! {
                alertController.addAction(action)
            }
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Student Locations Methods
    func getStudentLocationsData(completionClosure: () -> Void) {
        
        startActivityIndicator()
        
        ParseClient.sharedInstance().getStudentLocations(ParseClient.ParameterValues.Limit, order: ParseClient.ParameterValues.Order) {(result, error) in
            if let result = result {
                StudentInformationManager.sharedInstance().studentInformationArray = result
                performUIUpdatesOnMain {
                    completionClosure()
                }
                self.stopActivityIndicator()
            } else {
                print(error)
                self.stopActivityIndicator()
                self.showAlert(UIConstants.ErrorTitle.DownloadFailed, message: UIConstants.ErrorMessage.DownloadFailed)
            }
        }
    }
    
    func openURL(toOpen: String?) {
        guard let toOpen = toOpen else {
            print("No URL to open")
            return
        }
        
        guard let url = NSURL(string: toOpen) else {
            print("Not a valid URL to open")
            showAlert(UIConstants.ErrorTitle.NoValidURL, message: UIConstants.ErrorMessage.NoValidURL)
            return
        }
        
        let app = UIApplication.sharedApplication()
        
        // If the URL does not include http:// or https://, add http:// at the beginning
        // so that Safari can open more links on map and table view
        app.canOpenURL(url) ? app.openURL(url) : app.openURL(NSURL(string: "http://\(toOpen)")!)
    }
    
    
    // MARK: - Logout Method
    func logout () {
        dismissViewControllerAnimated(true, completion: nil)
        
        // Delete the session with Udacity's API
        UdacityClient.sharedInstance().deleteSession() { (result, error) in
            if result != nil {
                print("Logout successful")
            } else {
                print(error)
            }
        }
        
        // If user has logged in with Facebook, also logout the Facebook session
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("Facebook logout successful")
            FBSDKLoginManager().logOut()
        }
    }
    
    // MARK: - Configure Activity Indicator
    func configureActivityIndicator() {
        
        // FIXME: - Actual screen width does not let activity indicator cover whole view.
        // As a temporary fix, CGFloat value is increased by 10.
        let screenWidth = UIScreen.mainScreen().bounds.size.width + 10
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        activityIndicator.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.hidesWhenStopped = true
    }
    
    func startActivityIndicator() {
        performUIUpdatesOnMain() {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        performUIUpdatesOnMain() {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Navigate To Information Posting View
    func navigateToPostingView() {
        
        if (StudentInformationManager.sharedInstance().studentHasAlreadyPosted != nil) && StudentInformationManager.sharedInstance().studentHasAlreadyPosted! {
            let customActions = [UIAlertAction(title: "Overwrite", style: .Default, handler: {
                (sender: UIAlertAction) -> Void in
                self.showInformationPostingView()
            }), UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)]
            
            showAlert(UIConstants.ErrorTitle.AlreadyPosted, message: subtituteKeyInMessage(UIConstants.ErrorMessage.AlreadyPosted, key: UIConstants.StringKey.UserName, value: "\"\(StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONBodyKeys.FirstName]!) \(StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONBodyKeys.LastName]!)\""), customActions: customActions)
        } else {
            showInformationPostingView()
        }
    }
    
    func showInformationPostingView() {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("InformationPostingViewController")
        navigationController?.pushViewController(controller!, animated: true)
    }
    
    // MARK: - Check If Student Has Already Posted
    func checkIfstudentHasAlreadyPosted(uniqueKey: String) {
        
        ParseClient.sharedInstance().queryStudentLocation(uniqueKey) {(result, error) in
            if let result = result {
                if !(result.isEmpty) {
                    StudentInformationManager.sharedInstance().studentHasAlreadyPosted = true
                    StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONResponseKeys.ObjectId] = result[0].objectId
                } else {
                    StudentInformationManager.sharedInstance().studentHasAlreadyPosted = false
                }
            } else {
                print(error)
            }
        }
    }
    
    // MARK: - Create Student Information Dictionary By Using Public Data
    func createStudentInformationDictionaryFromPublicData(uniqueKey: String) {
        UdacityClient.sharedInstance().getPublicUserData(uniqueKey) { (result, error) in
            if let result = result {
                guard let firstName = result[UdacityClient.JSONResponseKeys.FirstName] else {
                    print("No first_name")
                    return
                }
                
                guard let lastName = result[UdacityClient.JSONResponseKeys.LastName] else {
                    print("No last_name")
                    return
                }
                
                StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONBodyKeys.FirstName] = firstName
                StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONBodyKeys.LastName] = lastName
                StudentInformationManager.sharedInstance().studentInformationDictionary[ParseClient.JSONBodyKeys.UniqueKey] = StudentInformationManager.sharedInstance().accountID!
            } else {
                print(error)
            }
        }
    }
    
    // MARK: Helpers
    
    // Substitute the key for the value that is contained within the alert message
    func subtituteKeyInMessage(message: String, key: String, value: String) -> String? {
        if message.rangeOfString(key) != nil {
            return message.stringByReplacingOccurrencesOfString(key, withString: value)
        } else {
            return nil
        }
    }
    
}
