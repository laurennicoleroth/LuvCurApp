//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@objc
protocol SidePanelViewControllerDelegate {
//  func animalSelected(animal: Animal)
}

class SidePanelViewController: UIViewController {
  
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentUserImage: UIImageView!
    
    
  var ref = FirebaseDataService.dataService.BASE_REF
  var currentUserName : String?
  var currentUserEmail : String?
  var currentUserFBID : String?
  var currentUserPicURL : NSURL?
  
  var profile_items: Array<Profile>!
  
  struct TableView {
    struct CellIdentifiers {
      static let ProfileCell = "ProfileCell"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if ref.authData != nil {
        // user authenticated
        print(ref.authData)
        usernameLabel.text = ref.authData.uid

    } else {
        // No user is signed in
        print("no user")
    }
    
    if(FBSDKAccessToken.currentAccessToken() != nil) {
        print(FBSDKAccessToken.currentAccessToken().permissions)
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
        print(graphRequest)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            self.usernameLabel.text = result.valueForKey("name") as? String
            
            self.currentUserFBID = result.valueForKey("id") as? String
            
            let url = NSURL(string: "https://graph.facebook.com/\(self.currentUserFBID!)/picture?type=large&return_ssl_resources=1")
//            self.imageView.image = UIImage(data: NSData(contentsOfURL: url!)!)
            self.currentUserImage.image = UIImage(data: NSData(contentsOfURL: url!)!)
        })
    } else {
        print("no token")
    }
    
    currentUserImage.layer.cornerRadius = self.currentUserImage.frame.size.width / 2
    currentUserImage.clipsToBounds = true
    
    tableView.reloadData()
    
  }
  
    @IBAction func logoutUser() {
        print("logging out user")
        ref.unauth()
        performSegueWithIdentifier("userLoggedOut", sender: nil)
    }
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return profile_items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.ProfileCell, forIndexPath: indexPath) as! ProfileCell
    cell.configureForAnimal(profile_items[indexPath.row])
    return cell
  }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}

class ProfileCell: UITableViewCell {
  
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var imageNameLabel: UILabel!
  
  func configureForAnimal(profile: Profile) {
    itemImageView.image = profile.image
    imageNameLabel.text = profile.title
  }
  
}