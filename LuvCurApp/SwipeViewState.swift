//
//  SwipeViewState.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/23/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

enum RotationDirection {
    case RotationTowardsCenter
    case RotationAwayFromCenter
}

class SwipeViewState {
    var originalCenter : CGPoint
    
    var rotationDirection : RotationDirection;
    
    init() {
        self.originalCenter = CGPointMake(0, 0)
        self.rotationDirection = .RotationTowardsCenter
    }
}