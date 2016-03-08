//
//  ViewController.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/22/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import UIKit
import Firebase

class CardsViewController: UIViewController
{
    let firebase = Firebase(url:"https://luvcurapp.firebaseio.com")
    let leftMenuWidth:CGFloat = 260
    
    var users : [User] = [
        User(name: "Hugh Laurie", bio: "Actor", image: UIImage(named: "cards_1")!, username: "hughlaurie"),
        User(name: "Megan Fox", bio: "Actor", image: UIImage(named: "cards_2")!, username: "meganfox"),
        User(name: "Jesse Pinkman", bio: "Actor", image: UIImage(named: "cards_3")!, username: "jessepinkman"),
        User(name: "Kate Night", bio: "Actor", image: UIImage(named: "cards_4")!, username: "katenight"),
        User(name: "Sheldon Cooper", bio: "Actor", image: UIImage(named: "cards_5")!, username: "sheldoncooper"),
        User(name: "Default Person", bio: "Actor", image: UIImage(named: "default-user")!, username: "defaultperson"),
        ]
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardStack = CardStackView(frame: self.frontCardViewFrame())
        cardStack.popCardViewWithFrame = self.popCardViewWithFrame
        
        self.navigationController?.navigationBar.topItem?.title = "LuvCur"
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "NotoSans", size: 34)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        cardStack.reloadContent()
        
        self.view.addSubview(cardStack)
    }
    
   
    //MARK: Stack Card View animation
    func popCardViewWithFrame(frame: CGRect) -> UIView? {
        if(users.count == 0) {
            return nil
        } else {
            let user : User = users.removeLast()
            let imageView = UIImageView()
            
            imageView.image = user.image
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            
            return imageView
        }
    }
    
    func tappedImageView(sender: AnyObject) -> () {
        if let imageView = sender as? UIView {
            UIView.animateWithDuration(0.5, animations: {
                imageView.alpha = 0
                imageView.transform = CGAffineTransformMakeScale(0.01, 0.01)
            })
        }
    }
    
    func frontCardViewFrame () -> CGRect {
        let horizontalPadding : CGFloat = 15
        let topPadding : CGFloat = 120
        let bottomPadding : CGFloat = 120
        
        return CGRectMake(horizontalPadding,
            topPadding,
            CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
            CGRectGetHeight(self.view.frame) - (bottomPadding) - (topPadding))
    }
    
    //MARK: Firebase
    func fetchUsersFromFirebase() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        firebase.observeEventType(.Value, withBlock: { snapshot in
            var firebaseUsers = [NSDictionary]()
            
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                firebaseUsers.append(dict)
            }
            
//            for user in firebaseUsers {
//                self.users.append(User(name: user["name"] as! String, bio: user["photoBase64"] as! String, image: UIImage?, username: String))
//            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
}

