//
//  SwipeOptions.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/23/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

class SwipeOptions {
    var swipeCancelledAnimationDuration : Double
    var swipeCancelledAnimationOptions : UIViewAnimationOptions
    var swipeAnimationDuration : CGFloat
    
    var swipeAnimationOptions : UIViewAnimationOptions
    var threshold : CGFloat
    
    var rotationFactor : CGFloat
    
    var onPan : (PanState -> ())
    var onChosen : (SwipeResult -> ())
    
    init()  {
        swipeCancelledAnimationDuration = 0.2
        swipeCancelledAnimationOptions = UIViewAnimationOptions.CurveEaseOut
        
        swipeAnimationDuration = 0.15;
        swipeAnimationOptions = UIViewAnimationOptions.CurveEaseIn;
        
        rotationFactor = 3.0;
        
        threshold = 100.0
        
        onPan = { _ -> () in }
        onChosen = { (result : SwipeResult) -> () in
            let duration = 0.15
            let options = UIViewAnimationOptions.CurveEaseInOut
            
            let viewRect = result.view!.frame
            let superviewRect = result.view!.superview!.frame
            let translation = result.translation
            
            let destination = viewRect.extendOutOfBounds(superviewRect, translationVector: translation)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: options, animations: {
                result.view!.frame = destination;
                }, completion: {(finished : Bool) -> () in
                    if (finished) {
                        result.view!.removeFromSuperview()
                        result.onCompletion()
                    }
            })
        }
    }

}

extension CGRect {
    func extendOutOfBounds(bounds : CGRect, translationVector : CGPoint) -> CGRect {
        var result = self;
        while (!CGRectIsNull(CGRectIntersection(result, bounds))) {
            result = result + translationVector
        }
        
        return result
    }
}

extension CGFloat {
    var toRadians : CGFloat { return self * 3.14159265 / 180.0 }
}

func + (left : CGRect, right : CGPoint) -> CGRect {
    return CGRectOffset(left, right.x, right.y)
}

func + (left : CGPoint, right : CGPoint) -> CGPoint {
    return CGPointMake(left.x + right.x, left.y + right.y)
}

func - (left : CGPoint, right : CGPoint) -> CGPoint {
    return CGPointMake(left.x - right.x, left.y - right.y)
}