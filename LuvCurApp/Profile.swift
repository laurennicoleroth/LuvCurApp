//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class Profile {
  
  let title: String
  let image: UIImage?
  var email : String?
  var facebookUID : String?
    
  
  init(title: String, image: UIImage?) {
    self.title = title
    self.image = image
  }
  
  class func profileItems() -> Array<Profile> {
    return [ Profile(title: "My Profile", image: UIImage(named: "profile-button")),
             Profile(title: "Match Filters", image: UIImage(named: "profile-button")),
             Profile(title: "Preferences", image: UIImage(named: "profile-button")),
             Profile(title: "Account", image: UIImage(named: "profile-button"))
            ]
  }
  
  class func matchItems() -> Array<Profile> {
    return [ Profile(title: "Matches", image: UIImage(named: "ID-10034505.jpg")),
      ]
  }
    
}