//
//  ParseConstants.swift
//  On The Map
//
//  Created by Ali Kayhan on 10/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

// MARK: - ParseClient (Constants)

extension ParseClient {
    
    // MARK: - Constants
    struct Constants {
        
        // MARK: - API Key
        static let ApiKey : String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: - Application ID
        static let ApplicationID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: - URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse"
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: - StudentLocations
        static let GetStudentLocation = "/classes/StudentLocation"
        static let PostStudentLocation = "/classes/StudentLocation"
        static let QueryStudentLocation = "/classes/StudentLocation"
        static let UpdateStudentLocation = "/classes/StudentLocation/{objectId}"
    }
    
    // MARK: - Header Keys
    struct HeaderKeys {
        static let ApiKey = "X-Parse-REST-API-Key"
        static let ApplicationID = "X-Parse-Application-Id"
    }
    
    // MARK: - URL Keys
    struct URLKeys {
        static let ObjectId = "{objectId}"
    }

    // MARK: - URL Parameter Keys
    struct ParameterKeys {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        static let Where = "where"
        
    }
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        
        // MARK: - General
        static let UniqueKey = "uniqueKey"
        
        // MARK: - Student
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MediaURL = "mediaURL"
        
        // MARK: - Location
        static let MapString = "mapString"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: - General
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let Results = "results"
        
        // MARK: - Student
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MediaURL = "mediaURL"
        
        // MARK: - Location
        static let MapString = "mapString"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        
        // MARK: - Parse Access and Control List
        static let ACL = "ACL"
    }
    
}
