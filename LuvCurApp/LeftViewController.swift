//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case MyProfile = 0
    case MatchFilters
    case Preferences
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["My Profile", "Match Filters", "Preferences"]
    var myProfileViewController: UIViewController!
    var matchFiltersViewController: UIViewController!
    var preferencesViewController: UIViewController!
    
    //Mark : Junk, clear out
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
    var javaViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = "default-user"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: view.frame.width / 6, y: 10, width: 150, height: 150)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        self.tableView.separatorColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let myProfileViewController = storyboard.instantiateViewControllerWithIdentifier("MyProfileViewController") as! MyProfileViewController
        self.myProfileViewController = UINavigationController(rootViewController: myProfileViewController)
        
        let matchFiltersViewController = storyboard.instantiateViewControllerWithIdentifier("MatchFiltersViewController") as! MatchFiltersViewController
        self.matchFiltersViewController = UINavigationController(rootViewController: matchFiltersViewController)
        
        let preferencesViewController = storyboard.instantiateViewControllerWithIdentifier("PreferencesViewController") as! PreferencesViewController
        self.preferencesViewController = UINavigationController(rootViewController: preferencesViewController)
        
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.backgroundColor = UIColor(red: 64/255, green: 170/255, blue: 239/255, alpha: 1.0)
        cell.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .MyProfile:
            self.slideMenuController()?.changeMainViewController(self.myProfileViewController, close: true)
            break
        
        case .MatchFilters:
            self.slideMenuController()?.changeMainViewController(self.matchFiltersViewController, close: true)
            break
            
        case .Preferences:
            self.slideMenuController()?.changeMainViewController(self.preferencesViewController, close: true)
            break
      
        default:
            break
        }
    }
    
}