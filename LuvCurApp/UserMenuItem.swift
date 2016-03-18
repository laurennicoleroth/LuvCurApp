//
//  ProfileItem.swift
//  
//
//  Created by Lauren Nicole Roth on 3/17/16.
//
//

import Foundation
import UIKit

class UserMenuItem {
    
    let title: String
    let image: UIImage?
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func userMenuItems() -> Array<UserMenuItem> {
        return [ UserMenuItem(title: "Profile", image: UIImage(named: "ID-100113060.jpg")),
                 UserMenuItem(title: "Match Filters", image: UIImage(named: "ID-100113060.jpg"))
        ]
    }
  
}