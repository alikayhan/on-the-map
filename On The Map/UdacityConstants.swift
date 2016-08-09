//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: - Constants
    struct Constants {
        
        // MARK: - URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: - Session
        static let Session = "/session"
        
        // MARK: - User Data
        static let GetPublicUserData = "/users/{userId}"
    }
    
    // MARK: - URL Keys
    struct URLKeys {
        static let userID = "{userId}"
    }
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: - Account
        static let Account = "account"
        static let Registered = "registered"
        static let Key  = "key"
        
        // MARK: - Session
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
        
        // MARK: - Student
        static let User = "user"
        static let LastName = "last_name"
        static let FirstName = "first_name"
    }

}
