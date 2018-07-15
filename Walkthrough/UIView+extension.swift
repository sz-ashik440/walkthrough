//
//  UIView+extension.swift
//  Walkthrough
//
//  Created by sz ashik on 7/15/18.
//  Copyright © 2018 sz. All rights reserved.
//

import UIKit

extension UIView {
    func slideIn(durateion: TimeInterval = 1, completionDelegate: Any? = nil, direction: String) {
        let slideFromLeftTransition = CATransition()
        
        if let delegate = completionDelegate {
            slideFromLeftTransition.delegate = (delegate as! CAAnimationDelegate)
        }
        
        slideFromLeftTransition.type = kCATransitionPush
        slideFromLeftTransition.subtype = direction
        slideFromLeftTransition.duration = durateion
        slideFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideFromLeftTransition.fillMode = kCAFillModeRemoved
        
        self.layer.add(slideFromLeftTransition, forKey: "slideFromLeftTransition")
    }
}

