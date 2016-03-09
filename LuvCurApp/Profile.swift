//
//  Profile.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/8/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    let title: String
    let creator: String
    let image: UIImage?
    
    init(title: String, creator: String, image: UIImage?) {
        self.title = title
        self.creator = creator
        self.image = image
    }
    
    class func profileItems() -> Array<User> {
        return [ User(name: "Name", bio: "Bio", image: UIImage(named: "ID-100113060.jpg"), username: "username") ]
    }
    

}