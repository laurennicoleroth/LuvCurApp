//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit


class Profile {
  
  let title: String
  let image: UIImage?
  let segueID: String?
  
    init(title: String, image: UIImage?, segue: String?) {
    self.title = title
    self.image = image
    self.segueID = segue
  }
  
  class func profileItems() -> Array<Profile> {
    return [ Profile(title: "My Profile", image: UIImage(named: "ID-100113060.jpg"), segue: "myProfile"),
        Profile(title: "Match Filters", image: UIImage(named: "ID-100113060.jpg"), segue: "matchFilters")
            ]
  }
  
//  class func matchItems() -> Array<Profile> {
//    return [ Profile(title: "Matches", image: UIImage(named: "ID-10034505.jpg"), segue),
//      ]
//  }

}