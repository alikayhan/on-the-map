//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Ali Kayhan on 13/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UdacityClient (Convenient Resource Methods)

extension UdacityClient {
    
    // MARK: - Create Session
    func createSession(userName: String, password: String, completionHandlerForCreateSession: (sessionID: String?, accountID: String?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let method: String = Methods.Session
        
        let jsonBody = "{\"\(UdacityClient.JSONBodyKeys.Udacity)\": {\"\(UdacityClient.JSONBodyKeys.Username)\": \"\(userName)\", \"\(UdacityClient.JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        /* Make the request */
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForCreateSession(sessionID: nil, accountID: nil, error: error)
            } else {
                if let sessionID = results.valueForKeyPath("\(UdacityClient.JSONResponseKeys.Session).\(UdacityClient.JSONResponseKeys.ID)") as? String, let accountID = results.valueForKeyPath("\(UdacityClient.JSONResponseKeys.Account).\(UdacityClient.JSONResponseKeys.Key)") as? String {
                    completionHandlerForCreateSession(sessionID: sessionID, accountID: accountID, error: nil)
                } else {
                    completionHandlerForCreateSession(sessionID: nil, accountID: nil, error: NSError(domain: "createSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse createSession"]))
                }
            }
        }
    }
    
    // MARK: - Create Session with Facebook Authentication
    func createSessionWithFacebookAuthentication(accessToken: String, completionHandlerForCreateSession: (sessionID: String?, accountID: String?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let method: String = Methods.Session
        
        let jsonBody = "{\"\(UdacityClient.JSONBodyKeys.FacebookMobile)\": {\"\(UdacityClient.JSONBodyKeys.AccessToken)\": \"\(accessToken)\"}}"
        
        /* Make the request */
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForCreateSession(sessionID: nil, accountID: nil, error: error)
            } else {
                if let sessionID = results.valueForKeyPath("\(UdacityClient.JSONResponseKeys.Session).\(UdacityClient.JSONResponseKeys.ID)") as? String, let accountID = results.valueForKeyPath("\(UdacityClient.JSONResponseKeys.Account).\(UdacityClient.JSONResponseKeys.Key)") as? String {
                    completionHandlerForCreateSession(sessionID: sessionID, accountID: accountID, error: nil)
                } else {
                    completionHandlerForCreateSession(sessionID: nil, accountID: nil, error: NSError(domain: "createSessionWithFacebookAuthentication parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse createSessionWithFacebookAuthentication"]))
                }
            }
        }
    }
    
    
    // MARK: - Delete Session
    func deleteSession(completionHandlerForDeleteSession: (result: String?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let method: String = Methods.Session
        
        /* Make the request */
        taskForDELETEMethod(method) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForDeleteSession(result: nil, error: error)
            } else {
                if let results = results.valueForKeyPath("\(UdacityClient.JSONResponseKeys.Session).\(UdacityClient.JSONResponseKeys.ID)") as? String {
                    completionHandlerForDeleteSession(result: results, error: nil)
                } else {
                    completionHandlerForDeleteSession(result: nil, error: NSError(domain: "deleteSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse deleteSession"]))
                }
            }
        }
    }
    
    // MARK: - Get Public User Data
    func getPublicUserData(userID: String, completionHandlerForGetPublicUserData: (result: [String: AnyObject]?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let mutableMethod: String = Methods.GetPublicUserData
        guard let mutatedMethod = subtituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.userID, value: userID) else {
            print("Could not mutate the method")
            return
        }
        
        /* Make the request */
        taskForGETMethod(mutatedMethod) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForGetPublicUserData(result: nil, error: error)
            } else {
                if let results = results[UdacityClient.JSONResponseKeys.User] as? [String: AnyObject] {
                    completionHandlerForGetPublicUserData(result: results, error: nil)
                } else {
                    completionHandlerForGetPublicUserData(result: nil, error: NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getPublicUserData"]))
                }
            }
        }
    }
    
}
