//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//

import UIKit

class MainViewController: UIViewController {
    
    let firebase = FirebaseDataService.dataService.BASE_REF
    var users : [User] = [
        User(name: "Hugh Laurie", bio: "Actor", image: UIImage(named: "cards_1")!, username: "hughlaurie"),
        User(name: "Megan Fox", bio: "Actor", image: UIImage(named: "cards_2")!, username: "meganfox"),
        User(name: "Jesse Pinkman", bio: "Actor", image: UIImage(named: "cards_3")!, username: "jessepinkman"),
        User(name: "Kate Night", bio: "Actor", image: UIImage(named: "cards_4")!, username: "katenight"),
        User(name: "Sheldon Cooper", bio: "Actor", image: UIImage(named: "cards_5")!, username: "sheldoncooper"),
        User(name: "Default Person", bio: "Actor", image: UIImage(named: "default-user")!, username: "defaultperson"),
    ]
    
    //MARK - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        let cardStack = CardStackView(frame: self.frontCardViewFrame())
        cardStack.popCardViewWithFrame = self.popCardViewWithFrame
        
        self.navigationController?.navigationBar.topItem?.title = "LuvCur"
        
        cardStack.reloadContent()
        
        self.view.addSubview(cardStack)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

}

