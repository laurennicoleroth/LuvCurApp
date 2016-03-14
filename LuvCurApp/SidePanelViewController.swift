//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
//  func animalSelected(animal: Animal)
}

class SidePanelViewController: UIViewController {
  
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  var ref = FirebaseDataService.dataService.BASE_REF
  
  var profile_items: Array<Profile>!
  
  struct TableView {
    struct CellIdentifiers {
      static let AnimalCell = "AnimalCell"
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
    let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.AnimalCell, forIndexPath: indexPath) as! AnimalCell
    cell.configureForAnimal(profile_items[indexPath.row])
    return cell
  }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}

class AnimalCell: UITableViewCell {
  
  @IBOutlet weak var animalImageView: UIImageView!
  @IBOutlet weak var imageNameLabel: UILabel!
  @IBOutlet weak var imageCreatorLabel: UILabel!
  
  func configureForAnimal(profile: Profile) {
    animalImageView.image = profile.image
    imageNameLabel.text = profile.title
  }
  
}