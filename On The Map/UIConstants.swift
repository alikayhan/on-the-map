//
//  UIConstants.swift
//  On The Map
//
//  Created by Ali Kayhan on 19/07/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit

struct UIConstants {
    
    // MARK: - Colors
    struct Color {
        static let BackgroundColorTop = UIColor(hexString: "#FFFFFF")
        static let BackgroundColorBottom = Color.UdacityBlue.CGColor
        
        static let UdacityBlue = UIColor(hexString: "#02B3E4")
        static let GreyColor = UIColor(hexString: "#E0E0DD")
        static let LightBlueColor = UIColor(hexString: "#DFF5FC")
        static let DarkBlueColor = UIColor(hexString: "#0080D6")
    }
    
    // MARK: - Fonts
    struct Fonts {
        static let LoginPageRegularFont = UIFont(name: "Roboto-Regular", size: 17)
        static let LoginPageMediumFont = UIFont(name: "Roboto-Medium", size: 17)
        static let LoginPageThinFont = UIFont(name: "Roboto-Regular", size: 17)
        
        static let PromptLabelRegularFont = UIFont(name: "Roboto-Thin", size: 26)
        static let PromptLabelMediumFont = UIFont(name: "Roboto-Regular", size: 26)
        
        static let InformationPostingPageTextFieldRegularFont = UIFont(name: "Roboto-Regular", size: 17)
        static let InformationPostingPageButtonRegularFont = UIFont(name: "Roboto-Regular", size: 17)
    }
    
    // MARK: - Titles
    struct Title {
        static let LoginButtonTitle = "Login"
        static let SignUpButtonTitle = "Don't have an account? Sign Up"
        static let LoginWithFacebookButtonTitle = "Sign in with Facebook"
        
        static let PromptLabelTopTitle = "Where are you"
        static let PromptLabelMiddleTitle = "studying"
        static let PromptLabelBottomTitle = "today?"
        static let FindOnTheMapButtonTitle = "Find on the Map"
        static let SubmitButtonTitle = "Submit"
    }
    
    // MARK: - Placeholders
    struct Placeholder {
        static let UserNameTextFieldPlaceholder = "Email"
        static let PasswordTextFieldPlaceholder = "Password"
        
        static let LocationTextFieldPlaceholder = "Enter your location here"
        static let URLTextFieldPlaceholder = "Enter a link to share here"
    }
    
    // MARK: - Error Title Strings
    struct ErrorTitle {
        static let UserNamePasswordEmpty = "Empty Email/Password"
        static let LoginFailed = "Invalid Credentials"
        static let FacebookLoginFailed = "Facebook Login Failed"
        static let NetworkProblem = "Network Problem"
        static let DownloadFailed = "Download Failed"
        static let NoValidURL = "No Valid URL"
        
        static let NoLocation = "No Location"
        static let GeocodingFailed = "Geocoding Failed"
        static let AlreadyPosted = "Already Posted"
        
        static let PostingFailed = "Posting Failed"
    }
    
    // MARK: - Error Message Strings
    struct ErrorMessage {
        static let UserNamePasswordEmpty = "Please make sure that you have entered both Email and Password information."
        static let LoginFailed = "Please make sure that you have entered the correct Email and Password for your Udacity account."
        static let FacebookLoginFailed = "Please make sure that you linked your Facebook account with Udacity account and try again."
        static let NetworkProblem = "Please make sure that your device is connected to Internet and try again."
        static let DownloadFailed = "The application could not retrieve the locations and information of the students from the server. Please try again."
        static let NoValidURL = "The detail information entered by the student is not a valid URL."
        
        
        static let NoLocation = "Please enter your location in order to pin yourself."
        static let GeocodingFailed = "Could not geocode the entered String."
        static let AlreadyPosted = "User {userName} has already posted a location and a link. Would you like to overwrite this?"
        
        static let PostingFailed = "Information entered could not be posted to the server. Try again."
    }
    
    // MARK: - String Keys
    struct StringKey {
        static let UserName = "{userName}"
    }
    
    // MARK: - UdacitySignupURL
    static let UdacitySignupURL = "https://www.udacity.com/account/auth#!/signup"
    
}
