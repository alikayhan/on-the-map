//
//  StudentInformationManager.swift
//  On The Map
//
//  Created by Ali Kayhan on 10/08/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation

class StudentInformationManager {
    
    var sessionID: String?
    var accountID: String?
    
    var studentInformationArray: [StudentInformation] = []
    var studentInformationDictionary: [String: AnyObject] = [:]
    
    var studentHasAlreadyPosted: Bool?
    
    // MARK: - Shared Instance as Singleton
    class func sharedInstance() -> StudentInformationManager {
        struct Singleton {
            static var sharedInstance = StudentInformationManager()
        }
        return Singleton.sharedInstance
    }
    
}
