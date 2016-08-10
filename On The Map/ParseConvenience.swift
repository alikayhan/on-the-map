//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Ali Kayhan on 12/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ParseClient (Convenient Resource Methods)

extension ParseClient {
    
    // MARK: - Get Student Locations
    func getStudentLocations(limit: Int, order: String, completionHandlerForGetStudentLocations: (result: [StudentInformation]?, error: NSError?) -> Void) {
    
        /* Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let method: String = Methods.GetStudentLocation
        
        let parameters = [ParseClient.ParameterKeys.Limit: limit, ParseClient.ParameterKeys.Order: order]
        
        /* Make the request */
        taskForGETMethod(method, parameters: parameters as! [String : AnyObject]) { (results, error) in
        
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForGetStudentLocations(result: nil, error: error)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    let studentLocations = StudentInformation.studentInformationArrayFromResults(results)
                    completionHandlerForGetStudentLocations(result: studentLocations, error: nil)
                } else {
                    completionHandlerForGetStudentLocations(result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }
    }
    
    // MARK: - Post Student Location
    func postStudentLocation(studentInformation: StudentInformation, completionHandlerForPostStudentLocation: (result: String?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has key), and HTTP body (if POST) */
        let method: String = Methods.PostStudentLocation

        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(studentInformation.uniqueKey)\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(studentInformation.firstName)\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(studentInformation.lastName)\", \"\(ParseClient.JSONBodyKeys.MapString)\": \"\(studentInformation.mapString)\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(studentInformation.mediaURL)\", \"\(ParseClient.JSONBodyKeys.Latitude)\": \(studentInformation.latitude), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(studentInformation.longitude)}"

        
        /* Make the request */
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostStudentLocation(result: nil, error: error)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.ObjectId] as? String {
                    completionHandlerForPostStudentLocation(result: results, error: nil)
                } else {
                    completionHandlerForPostStudentLocation(result: nil, error: NSError(domain: "postStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: - Update Student Location
    func updateStudentLocation(studentInformation: StudentInformation, completionHandlerForUpdateStudentLocation: (result: String?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has key), and HTTP body (if POST) */
        var mutableMethod: String = Methods.UpdateStudentLocation
        mutableMethod = subtituteKeyInMethod(mutableMethod, key: ParseClient.URLKeys.ObjectId, value: studentInformation.objectId)!
        
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(studentInformation.uniqueKey)\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(studentInformation.firstName)\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(studentInformation.lastName)\", \"\(ParseClient.JSONBodyKeys.MapString)\": \"\(studentInformation.mapString)\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(studentInformation.mediaURL)\", \"\(ParseClient.JSONBodyKeys.Latitude)\": \(studentInformation.latitude), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(studentInformation.longitude)}"
        
        /* Make the request */
        taskForPUTMethod(mutableMethod, jsonBody: jsonBody) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForUpdateStudentLocation(result: nil, error: error)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.UpdatedAt] as? String {
                    completionHandlerForUpdateStudentLocation(result: results, error: nil)
                } else {
                    completionHandlerForUpdateStudentLocation(result: nil, error: NSError(domain: "updateStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse updateStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: - Query Student Location
    func queryStudentLocation(uniqueKey: String, completionHandlerForQueryStudentLocation: (result: [StudentInformation]?, error: NSError?) -> Void) {
        
        /* Specify parameters, method (if has key), and HTTP body (if POST) */
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\":\"\(uniqueKey)\"}"
        
        let parameters = [ParseClient.ParameterKeys.Where: jsonBody]
        
        let method: String = Methods.QueryStudentLocation
        
        /* Make the request */
        taskForGETMethod(method, parameters: parameters) { (results, error) in
            
            /* Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForQueryStudentLocation(result: nil, error: error)
            } else {
                
                if let results = results[ParseClient.JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    let studentLocations = StudentInformation.studentInformationArrayFromResults(results)
                    completionHandlerForQueryStudentLocation(result: studentLocations, error: nil)
                } else {
                    completionHandlerForQueryStudentLocation(result: nil, error: NSError(domain: "queryStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse queryStudentLocations"]))
                }
            }
        }
    }
    
}
