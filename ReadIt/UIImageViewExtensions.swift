//
//  UIImageViewExtensions.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/8.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
