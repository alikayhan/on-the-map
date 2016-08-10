//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var udacityLogo: UIImageView!
    
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginWithFacebookButton: BorderedButton!
    
    // MARK: - Properties
    var keyboardOnScreen = false
    
    // MARK: - Lifecycle Functions
    override func viewWillAppear(animated: Bool) {
        configureBackground()
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func login(sender: UIButton) {
        
        userDidTapView(self)
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            showAlert(UIConstants.ErrorTitle.UserNamePasswordEmpty, message: UIConstants.ErrorMessage.UserNamePasswordEmpty)
        } else {
            setUIEnabled(false)

            UdacityClient.sharedInstance().createSession(usernameTextField.text!, password: passwordTextField.text!) { (sessionID, accountID, error) in
                performUIUpdatesOnMain {
                    if sessionID != nil && accountID != nil {
                        self.appDelegate.sessionID = sessionID
                        self.appDelegate.accountID = accountID
                        self.completeLogin()
                    } else if error?.userInfo["NSLocalizedDescription"] as! String == UdacityClient.ErrorDescription.InvalidCredentials {
                        self.showAlert(UIConstants.ErrorTitle.LoginFailed, message: UIConstants.ErrorMessage.LoginFailed)
                        self.setUIEnabled(true)
                    } else {
                        self.showAlert(UIConstants.ErrorTitle.NetworkProblem, message: UIConstants.ErrorMessage.NetworkProblem)
                        self.setUIEnabled(true)
                    }
                }
            }
        }
    }
    
    @IBAction func signUp(sender: UIButton) {
        openURL(UIConstants.UdacitySignupURL)
    }
    
    @IBAction func loginWithFacebook(sender: UIButton) {
        FBSDKLoginManager().logInWithReadPermissions(["public_profile"], fromViewController: self) { (result, error) -> Void in
            
            if (error != nil) {
                print("Facebook Login Error")
            } else if result.isCancelled {
                print("User Cancelled Facebook Login")
            } else {
                self.setUIEnabled(false)
                
                UdacityClient.sharedInstance().createSessionWithFacebookAuthentication(FBSDKAccessToken.currentAccessToken().tokenString) { (sessionID, accountID, error) in
                    performUIUpdatesOnMain {
                        if sessionID != nil && accountID != nil {
                            self.appDelegate.sessionID = sessionID
                            self.appDelegate.accountID = accountID
                            self.completeLogin()
                        } else if error?.userInfo["NSLocalizedDescription"] as! String == UdacityClient.ErrorDescription.InvalidCredentials {
                            self.showAlert(UIConstants.ErrorTitle.FacebookLoginFailed, message: UIConstants.ErrorMessage.FacebookLoginFailed)
                            self.setUIEnabled(true)
                        } else {
                            self.showAlert(UIConstants.ErrorTitle.NetworkProblem, message: UIConstants.ErrorMessage.NetworkProblem)
                            self.setUIEnabled(true)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    private func completeLogin() {
        checkIfstudentHasAlreadyPosted(appDelegate.accountID!)
        createStudentInformationDictionaryFromPublicData(appDelegate.accountID!)
        
        stopActivityIndicator()
        
        let controller = storyboard!.instantiateViewControllerWithIdentifier("MapListTabBarController") as! UITabBarController
        presentViewController(controller, animated: true, completion: nil)
    }

}


// MARK: - LoginViewController: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(usernameTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
}


// MARK: - LoginViewController (Configure UI)
extension LoginViewController {
    
    private func configureUI() {
        configureBackground()
        setButtons()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        usernameTextField.tag = 1
        passwordTextField.tag = 2
        
        configureTextField(usernameTextField)
        configureTextField(passwordTextField)
    }
    
    private func setUIEnabled(enabled: Bool) {
        usernameTextField.enabled = enabled
        passwordTextField.enabled = enabled
        loginButton.enabled = enabled
        
        // Adjust login button alpha
        if enabled {
            stopActivityIndicator()
            loginButton.alpha = 1.0
        } else {
            startActivityIndicator()
            loginButton.alpha = 0.5
        }
    }
    
    private func configureBackground() {
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [UIConstants.Color.BackgroundColorTop.CGColor, UIConstants.Color.UdacityBlue.CGColor]
        backgroundGradient.locations = [0.0, 1.0]
        backgroundGradient.frame = view.frame
        view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    }
    
    private func setButtons() {
        loginButton.setTitle(UIConstants.Title.LoginButtonTitle, forState: .Normal)
        loginButton.titleLabel?.font = UIConstants.Fonts.LoginPageRegularFont
        
        signUpButton.setTitle(UIConstants.Title.SignUpButtonTitle, forState: .Normal)
        signUpButton.titleLabel?.font = UIConstants.Fonts.LoginPageMediumFont
        
        loginWithFacebookButton.setTitle(UIConstants.Title.LoginWithFacebookButtonTitle, forState: .Normal)
        loginWithFacebookButton.titleLabel?.font = UIConstants.Fonts.LoginPageRegularFont
    }
    
    private func configureTextField(textField: UITextField) {
        switch textField.tag {
        case 1:
            textField.placeholder = UIConstants.Placeholder.UserNameTextFieldPlaceholder
            textField.keyboardType = .EmailAddress
        case 2:
            textField.placeholder = UIConstants.Placeholder.PasswordTextFieldPlaceholder
            textField.secureTextEntry = true
        default:
            break
        }
        
        textField.font = UIConstants.Fonts.LoginPageRegularFont
        textField.textColor = UIConstants.Color.UdacityBlue
        
        textField.borderStyle = .None
        textField.layer.cornerRadius = 4.0
        
        textField.autocorrectionType = .No
        textField.backgroundColor = UIConstants.Color.LightBlueColor
        
        //Add padding for the text field
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.Always
        
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName:UIConstants.Fonts.LoginPageThinFont!])
        
        textField.tintColor = UIConstants.Color.UdacityBlue
        textField.delegate = self
    }
    
}
