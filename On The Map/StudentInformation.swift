//
//  StudentInformation.swift
//  On The Map
//
//  Created by Ali Kayhan on 10/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation

// MARK: - Student Information Struct

// This struct is used to create Student Information objects 
// after GETting Student Locations from Parse and before POSTing 
// or PUTting Student Location into Parse.

struct StudentInformation {
    
    let firstName: String!
    let lastName: String!
    var latitude: Double!
    var longitude: Double!
    var mapString: String!
    var mediaURL: String!
    let uniqueKey: String!
    let objectId: String!
    
    // MARK: - Initializers
    
    // Construct a Student Information from a dictionary
    init(dictionary: [String:AnyObject]) {
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String
    }
    
    static func studentInformationArrayFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentInformationArray = [StudentInformation]()
        
        // Iterate through array of dictionaries, each Student Information is a dictionary
        for result in results {
            studentInformationArray.append(StudentInformation(dictionary: result))
        }
        
        return studentInformationArray
    }

}
