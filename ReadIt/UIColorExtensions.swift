//
//  UIColorExtensions.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

extension UIColor {
    
    open static let primary = UIColor.rgb(red: 67, green: 205, blue: 135)
    
    open static let readingProgress = UIColor.primary
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
