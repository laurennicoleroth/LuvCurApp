//
//  Firebase.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 3/2/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://luvcurapp.firebaseio.com"

class FirebaseDataService {
    // create a static variable with only one instance in memory and it's globally accessible
    static let dataService = FirebaseDataService()
    
    private var _BASE_REF = Firebase(url: "\(URL_BASE)")
    private var _USER_REF = Firebase(url: "\(URL_BASE)/Users")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
}