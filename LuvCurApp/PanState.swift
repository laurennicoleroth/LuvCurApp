//
//  PanState.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/23/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

class PanState {
    var direction : SwipeDirection
    var view : UIView
    var thresholdRatio : CGFloat
    
    init(direction: SwipeDirection, view: UIView, thresholdRatio : CGFloat) {
        self.direction = direction
        self.view = view
        self.thresholdRatio = thresholdRatio
    }
}

