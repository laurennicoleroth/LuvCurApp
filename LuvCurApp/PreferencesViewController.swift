//
//  PreferencesViewController.swift
//  LoveCure
//
//  Created by Lauren Nicole Roth on 3/18/16.
//  Copyright © 2016 LoveCure. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Preferences")

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.setNavigationBarItem()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
