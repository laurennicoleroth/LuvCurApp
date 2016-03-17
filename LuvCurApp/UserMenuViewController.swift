//
//  UserMenuViewController.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/17/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import UIKit


protocol UserMenuViewControllerDelegate {
    func userMenuItemSelected(user_menu_item: UserMenuItem)
}

class UserMenuViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    
    var user_menu_items: Array<UserMenuItem>!
    
    struct UserMenuTableView {
        struct CellIdentifiers {
            static let UserMenuItemCell = "UserMenuItemCell"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.reloadData()
    }
}

// MARK: Table View Data Source

extension UserMenuViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user_menu_items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UserMenuTableView.CellIdentifiers.UserMenuItemCell, forIndexPath: indexPath) as! UserMenuItemCell
        cell.configureForUserMenuItem(user_menu_items[indexPath.row])
        return cell
    }
    
}

extension UserMenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedMenuItem = user_menu_items[indexPath.row]
//        delegate?.userMenuItemSelected(selectedMenuItem)
    }
    
}

class UserMenuItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    
    
    func configureForUserMenuItem(user_menu_item: UserMenuItem) {
        itemImageView.image = user_menu_item.image
        menuItemLabel.text = user_menu_item.title
    }
}