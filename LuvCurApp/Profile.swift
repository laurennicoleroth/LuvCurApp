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
  
  init(title: String, image: UIImage?) {
    self.title = title
    self.image = image
  }
  
  class func profileItems() -> Array<Profile> {
    return [ Profile(title: "Profile", image: UIImage(named: "ID-100113060.jpg")),
             Profile(title: "Match Filters", image: UIImage(named: "ID-100113060.jpg"))
            ]
  }
  
  class func matchItems() -> Array<Profile> {
    return [ Profile(title: "Matches", image: UIImage(named: "ID-10034505.jpg")),
      ]
  }
}