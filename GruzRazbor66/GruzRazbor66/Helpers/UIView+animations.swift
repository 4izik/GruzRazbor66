//
//  UIView+animations.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 16.07.2022.
//

import Foundation
import UIKit

extension UIView {
    func shakeHorizontally() {
        
        let animShake:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        
        animShake.values = [ 0, 15, -15, 15, 0 ]
        animShake.keyTimes = [0, NSNumber(value: 1.0/6.0), NSNumber(value: 3.0/6.0), NSNumber(value: 5.0/6.0), 1 ]
        animShake.duration = 0.4
        animShake.isAdditive = true
        
        self.layer.add(animShake, forKey: "animateShakeHorizontally")
    }
}
