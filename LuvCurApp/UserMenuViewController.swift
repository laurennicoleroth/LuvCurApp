//
//  UserMenuViewController.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/17/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import UIKit

@objc
protocol UserMenuViewControllerDelegate {

}

class UserMenuViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    
    var user_menu_items: Array<UserMenuItem>!
    
    struct UserMenuTableView {
        struct CellItentifiers {
            static let UserMenuItemCell = "UserMenuItemCell"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UserMenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}