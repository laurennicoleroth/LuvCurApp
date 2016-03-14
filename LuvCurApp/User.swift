//
//  User.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/22/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name : String?
    var bio : String?
    var imageURL : String?
    var image : UIImage?
    var username : String?
    
    let firebaseRef = FirebaseDataService()
    
    // create an initializer
    init(name: String, bio: String, image: UIImage?, username: String) {
        self.name = name
        self.bio = bio
        if image != nil {
          self.image = image!
        }
        self.username = username
    }
    
    
    func encodeImageToBase64() {
        var data: NSData = NSData()
        data = UIImageJPEGRepresentation(image!, 0.1)!
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let user: NSDictionary = ["username": username!, "photoBase64":base64String]
        let profile = firebaseRef.USER_REF
        profile.setValue(user)
    }
    
    
    private func createImageFromBase64(base64String: String?) -> UIImage? {
        let decodedData = NSData(base64EncodedString: base64String!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        return decodedImage!
    }
}