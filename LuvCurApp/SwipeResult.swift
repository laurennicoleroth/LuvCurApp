//
//  SwipeResult.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/23/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

class SwipeResult: NSObject {
    var view : UIView?
    var translation : CGPoint
    var direction : SwipeDirection
    var onCompletion : () -> ()
    
    override init() {
        translation = CGPoint(x: 0, y: 0)
        direction = SwipeDirection.None
        onCompletion = {}
    }
}