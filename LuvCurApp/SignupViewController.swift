//
//  SignupViewController.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/3/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController
{
    @IBOutlet weak var emailTextField: OLNThinTextField!
    @IBOutlet weak var usernameTextField: OLNThinTextField!
    @IBOutlet weak var passwordTextField: OLNThinTextField!
    @IBOutlet weak var repeatPasswordTextField: OLNThinTextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBAction func signupButtonTouched() {
        let email = emailTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if username != "" && email != "" && password != "" {
            
            // Set Email and Password for the New User.
            
            FirebaseDataSingleton.ds.REF_BASE.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    print(error)

                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    
                } else {
                    
                    // Create and Login the New User with authUser
                    FirebaseDataSingleton.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        
                        FirebaseDataSingleton.ds.REF_BASE.createUser(email, password: password,
                            withValueCompletionBlock: { error, result in
                                if error != nil {
                                    // There was an error creating the account
                                    print("There was an error creating the account: \(error)")
                                } else {
                                    let uid = result["uid"] as? String
                                    print("Successfully created user account with uid: \(uid)")
                                }
                        })
                    })
                    
                    // Store the uid for future access - handy!
                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                    
                    // Enter the app.
                    self.performSegueWithIdentifier("newUserLoggedIn", sender: nil)
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
