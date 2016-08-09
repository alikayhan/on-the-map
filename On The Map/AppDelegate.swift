//
//  AppDelegate.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sessionID: String?
    var accountID: String?
    
    var studentHasAlreadyPosted: Bool?
    var studentInformationDictionary: [String: AnyObject] = [:]
    
    var studentInformationArray: [StudentInformation] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
}
