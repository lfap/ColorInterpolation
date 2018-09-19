//
//  NSLayoutConstraint+Extension.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 17/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        guard let firstItemUnwrapped = firstItem else {
            return NSLayoutConstraint()
        }
        let newConstraint = NSLayoutConstraint(
            item: firstItemUnwrapped,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
