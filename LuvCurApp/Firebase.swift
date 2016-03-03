//
//  Firebase.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 3/2/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://luvcurios.firebaseio.com/"

class FirebaseDataSingleton {
    // create a static variable with only one instance in memory and it's globally accessible
    static let ds = FirebaseDataSingleton()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/Users")
    
    // For good code practice, create public variables to return private variables
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        // OR: let user = Firebase(url: "\(URL_BASE)/Users")
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("Users").childByAppendingPath(uid)
        return user!
    }
    
    // Dictionary for the signup/login provider (ex: provider : facebook)
    // grab a reference to a path and if it does note exist, it will when we save it
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
}