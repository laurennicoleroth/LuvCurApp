//
//  LoginViewController.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/3/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var viewSocialBtns: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    var buttonSelected: OLNSocialButton?
    
    var email : String? = "" {
        didSet {
            if email != nil {
                print(email)
            } else {
                print("Email is nil")
            }
        }
    }
    var password : String? = "" {
        didSet {
            if password != nil {
                print(password)
            } else {
                print("Password is nil")
            }
        }
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewUserPhoto.layer.borderColor = UIColor.whiteColor().CGColor
        imageViewUserPhoto.layer.borderWidth = 2
        imageViewUserPhoto.layer.cornerRadius = imageViewUserPhoto.bounds.size.height / 2.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && FirebaseDataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        }
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        buttonLogin.animationCircular(directionShow: true)
        buttonSignup.animationCircular(directionShow: true)
        viewSocialBtns.animationMoveUp(false, andHide: true)
    }
    
    //MARK: - IBActions
    @IBAction func endEditing(_: AnyObject) {
        if (buttonSelected != nil) {
            expandSocialButton(buttonSelected!)
            buttonSelected = nil
        } else {
            buttonLogin.animationCircular(directionShow: false)
            buttonSignup.animationCircular(directionShow: false)
            viewSocialBtns.animationMoveUp(false, andHide: false)
            self.view.endEditing(true)
        }
    }
    
    @IBAction func useSocial(sender: OLNSocialButton) {
        if sender.expanded {
            //Do Sign In
            switch sender.tag {
            case 101:
                loginToFacebook()
                
                //TODO: Add alternative signup methods
            case 102:
                print("tw")
            case 103:
                print("q+")
            default:
                print("setup tags in Social buttons")
            }
        }else{
            //expand
            buttonSelected = sender
            expandSocialButton(sender)
        }
    }
    
    @IBAction func loginSignupButtonTapped(sender: AnyObject) {
        
        print("login button tapped")
        if let email = textFieldEmail.text where email != "", let password = textFieldPassword.text where password != "" {
            
            // login/authenticate a user
            FirebaseDataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    
                    print(error.code)
                    
                    if error.code == STATUS_ACCOUNT_NOTEXIST {
                        // Create a new user account
                        FirebaseDataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Make sure your information is correct.")
                            } else {
                                // successfully created an account, save user id and
                                // log in user
                                DEFAULTS.setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                FirebaseDataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { err, authData in
                                    
                                    // Create a new firebase user if they used email to sign up
                                    let user = ["provider": authData.provider!]
                                    FirebaseDataService.dataService.createNewAccount(authData.uid, user: user)
                                })
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                            }
                        })
                    } else {
                        // Handle error if incorrect password
                        self.showErrorAlert("Could not log in.", msg: "You may have entered your password or email incorrectly.")
                    }
                    
                } else {
                    
                    DEFAULTS.setValue(authData.uid, forKey: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                }
            })
            
        } else {
            showErrorAlert("Missing Something?", msg: "You must enter an email and a password.")
        }
        
    }
    
    //MARK: Signup
    
    @IBAction func signUpNewUser() {
        self.email = textFieldEmail.text!
        self.password = textFieldPassword.text!
        
        if email != "" && password != "" {
            print("valid")
            
        }
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //-------------------
    // MARK: - Show Alert
    //-------------------
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it.", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Perform Logins and Segues
    func loginToFacebook() {
        // create new instance of facebookLogin
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("successfully logged in with facebook \(accessToken)")
                
                FirebaseDataService.dataService.BASE_REF.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    // store on our device the token/session of our user when they log in w Facebook
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in! \(authData)")
                        DEFAULTS.setValue(authData.uid, forKey: KEY_UID)
                        
                        
                        // Create a new firebase user if they used facebook to sign up
                        let user = ["provider": authData.provider!, "bio": "about me" ]
                        FirebaseDataService.dataService.createNewAccount(authData.uid, user: user)
                        
                        // move to new VC after logging in
                        self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                    }
                })
            }
        })
        
    }
    
    //MARK: - Animation logic
    func expandSocialButton(button: OLNSocialButton) {
        let willBeginExpanding = !button.expanded
        button.expand()
        
        //animated hide/show other social btns
        var btnsWillBeHidden = Set(button.superview!.subviews)
        btnsWillBeHidden.remove(button)
        for  btn in btnsWillBeHidden{
            btn.animationFade(directionFade: willBeginExpanding)
        }
        
        //animated move and hide/show textFields
        for  textField in [textFieldEmail, textFieldPassword]{
            textField.animationMoveUp(true, andHide: willBeginExpanding)
        }
        
        //animated show/hide user profile info
        imageViewUserPhoto.animationCircular(directionShow: willBeginExpanding, startTop: false)
        labelUserName.animationCircular(directionShow: willBeginExpanding, startTop: false)
    }
}


